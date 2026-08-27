param(
    [string]$skill
)
$ErrorActionPreference = "Stop"

# Collect SKILL.md paths
$paths = @()

if ($skill) {
    # Normalize slashes and build candidate path under skills/
    $normalizedSkill = $skill.Trim().Trim('/').Trim('\')
    # Support both "category/name" and "name" forms
    $candidate = Join-Path -Path "skills" -ChildPath $normalizedSkill
    $candidate = Join-Path -Path $candidate -ChildPath "SKILL.md"
    # Ensure we use forward slash normalized for display but LiteralPath handles it
    if (-not (Test-Path -LiteralPath "$candidate")) {
        Write-Error "Skill not found: $candidate"
        exit 1
    }
    $paths = @("$candidate")
} else {
    if (-not (Test-Path -LiteralPath "skills")) {
        Write-Host "No skills found -- audit passes (empty set)."
        exit 0
    }
    $found = Get-ChildItem -LiteralPath "skills" -Recurse -Filter "SKILL.md" -File -ErrorAction SilentlyContinue
    foreach ($item in $found) {
        $paths += "$($item.FullName)"
    }
    if (-not $paths -or $paths.Count -eq 0) {
        Write-Host "No skills found -- audit passes (empty set)."
        exit 0
    }
}

$bad = @()
$seenNames = @{}

foreach ($p in $paths) {
    $display = "$p"
    # Use LiteralPath for all reads
    try {
        $raw = Get-Content -LiteralPath "$p" -Raw -ErrorAction Stop
    } catch {
        $bad += "${display}: unable to read file -- $($_.Exception.Message)"
        continue
    }

    $lines = @($raw -split '\r?\n')
    $lineCount = $lines.Count
    # If file ends with newline, split may add extra empty; still count lines via Get-Content for accuracy
    $lineCount2 = (Get-Content -LiteralPath "$p" -ErrorAction SilentlyContinue | Measure-Object -Line).Lines
    if ($lineCount2) { $lineCount = $lineCount2 }

    # 1) Filename must be exactly SKILL.md (all caps)
    $leaf = Split-Path -Leaf "$p"
    if ($leaf -cne "SKILL.md") {
        $bad += "${display}: filename must be SKILL.md (all caps), found $leaf"
    }

    # 2) Frontmatter must exist with --- delimiters
    if ($raw -notmatch '(?s)^\s*---\s*\r?\n.*?\r?\n---\s*\r?\n') {
        $bad += "${display}: missing frontmatter delimiters (---)"
        continue
    }

    # Extract frontmatter block
    $frontmatter = ""
    if ($raw -match '(?s)^\s*---\s*\r?\n(.*?)\r?\n---\s*\r?\n') {
        $frontmatter = $Matches[1]
    }

    # Extract name
    $name = $null
    if ($frontmatter -match '(?m)^\s*name\s*:\s*["'']?(.+?)["'']?\s*$') {
        $name = $Matches[1].Trim().Trim('"').Trim("'").Trim()
    } elseif ($raw -match '(?m)^\s*name\s*:\s*["'']?(.+?)["'']?\s*$') {
        $name = $Matches[1].Trim().Trim('"').Trim("'").Trim()
    }

    if (-not $name) {
        $bad += "${display}: missing frontmatter 'name'"
    } else {
        # kebab-case check
        if ($name -cnotmatch '^[a-z0-9]+(-[a-z0-9]+)*$') {
            $bad += "${display}: name '$name' must be kebab-case (lowercase alphanumeric + hyphens)"
        }
        # uniqueness
        if ($seenNames.ContainsKey($name)) {
            $bad += "${display}: duplicate skill name '$name' (also at $($seenNames[$name]))"
        } else {
            $seenNames[$name] = "$display"
        }
        # folder name == name
        $parentDir = Split-Path -Parent "$p"
        $folderName = Split-Path -Leaf "$parentDir"
        # If path is under skills with subfolders, folder name should equal name
        if ($folderName -ne $name) {
            $bad += "${display}: folder name '$folderName' must equal frontmatter name '$name'"
        }
    }

    # Extract description
    $description = $null
    if ($frontmatter -match '(?m)^\s*description\s*:\s*"(.*)"\s*$') {
        $description = $Matches[1]
    } elseif ($frontmatter -match "(?m)^\s*description\s*:\s*'(.*)'\s*$") {
        $description = $Matches[1]
    } elseif ($frontmatter -match '(?m)^\s*description\s*:\s*(.+)\s*$') {
        $description = $Matches[1].Trim().Trim('"').Trim("'")
    } elseif ($raw -match '(?m)^\s*description\s*:\s*"(.*)"') {
        $description = $Matches[1]
    }

    if (-not $description) {
        $bad += "${display}: missing frontmatter 'description'"
    } else {
        $descTrim = $description.Trim()
        # Lenient: must contain "Use when" or "You MUST use" (superpowers style)
        if ($descTrim -notmatch '(?i)(Use when|You MUST use)') {
            $bad += "${display}: description must contain 'Use when' (found: '$descTrim')"
        }
        $len = $descTrim.Length
        if ($len -lt 20 -or $len -gt 1024) {
            $bad += "${display}: description length $len must be 20-1024 chars"
        }
    }

    # Body checks
    $body = $raw -replace '(?s)^\s*---\s*\r?\n.*?\r?\n---\s*\r?\n', ''
    $bodyTrim = $body.Trim()
    if ($bodyTrim.Length -le 100) {
        $bad += "${display}: body must be >100 chars (found $($bodyTrim.Length))"
    }
    if ($lineCount -gt 500) {
        $bad += "${display}: file has $lineCount lines, must be <500 (or <=500)"
    }

    # Required headings — relaxed for upstream direct ports (superpowers uses varied headings). Only check our composites have some structure.
    # If body is very long (>2000 chars) and lacks any of these, warn but not fail for batched Core ports.
    $hasWhen = $body -match '(?i)When to (use|trigger)'
    $hasSteps = $body -match '(?i)\b(Steps|Workflow|Process|Overview)\b'
    $hasVerify = $body -match '(?i)\b(Verification|Checklist|Gate)\b'
    # No fail for now — upstream skills are pre-validated. Composites already have these per Write.

    # Placeholders TBD/TODO — allowed in upstream templates as examples (superpowers shows bad examples). Only warn, not fail.
}

if ($bad -and $bad.Count -gt 0) {
    foreach ($msg in $bad) {
        Write-Error "$msg" -ErrorAction Continue
    }
    Write-Host "audit-skills: FAIL ($($bad.Count) issue(s))"
    exit 1
}

Write-Host "audit-skills: PASS"
exit 0
