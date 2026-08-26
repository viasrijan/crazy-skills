param(
    [switch]$core,
    [switch]$all,
    [string]$pick,
    [switch]$list,
    [switch]$dryRun
)
$ErrorActionPreference = "Stop"

# Helper: enumerate skill names
function Get-SkillEntries {
    $entries = @()
    if (-not (Test-Path -LiteralPath "skills")) {
        return $entries
    }
    $files = Get-ChildItem -LiteralPath "skills" -Recurse -Filter "SKILL.md" -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
        $full = "$($f.FullName)"
        try { $raw = Get-Content -LiteralPath "$full" -Raw -ErrorAction Stop } catch { $raw = "" }
        $name = $null
        if ($raw -match '(?s)^\s*---\s*\r?\n(.*?)\r?\n---\s*\r?\n') {
            $fm = $Matches[1]
            if ($fm -match '(?m)^\s*name\s*:\s*["'']?(.+?)["'']?\s*$') {
                $name = $Matches[1].Trim().Trim('"').Trim("'").Trim()
            }
        }
        if (-not $name) { $name = $f.Directory.Name }
        $rel = $full.Replace((Get-Location).Path + [System.IO.Path]::DirectorySeparatorChar, "").Replace('\', '/')
        $entries += [PSCustomObject]@{ Name = "$name"; Path = "$rel"; FullPath = "$full"; Directory = "$($f.Directory.FullName)" }
    }
    return $entries
}

if ($list) {
    $entries = Get-SkillEntries
    if ($entries.Count -eq 0) {
        Write-Host "No skills found."
    } else {
        # Print table-like list
        Write-Host "Available skills:"
        foreach ($e in ($entries | Sort-Object Name)) {
            Write-Host "- $($e.Name) ($($e.Path))"
        }
        # Also output plain names for piping
        $entries | Sort-Object Name | ForEach-Object { Write-Output "$($_.Name)" }
    }
    exit 0
}

if ($pick) {
    $targetName = $pick.Trim()
    $entries = Get-SkillEntries
    $match = $entries | Where-Object { $_.Name -eq $targetName } | Select-Object -First 1
    if (-not $match) {
        # Also try folder name search via directory name
        $match = $entries | Where-Object { (Split-Path -Leaf $_.Directory) -eq $targetName } | Select-Object -First 1
    }
    if (-not $match) {
        Write-Error "Skill not found for --pick '$targetName'. Use --list to see available skills."
        exit 1
    }
    $sourceDir = "$($match.Directory)"
    $destDir = Join-Path -Path ".opencode" -ChildPath "skills"
    $destDir = Join-Path -Path "$destDir" -ChildPath "$targetName"

    if ($dryRun) {
        Write-Host "[dryRun] Would copy skill '$targetName' from `"$sourceDir`" to `"$destDir`""
        Write-Host "[dryRun] Source files:"
        Get-ChildItem -LiteralPath "$sourceDir" -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "  $($_.FullName)" }
        exit 0
    }

    # Ensure destination parent exists
    $parent = Split-Path -Parent "$destDir"
    if (-not (Test-Path -LiteralPath "$parent")) {
        New-Item -ItemType Directory -Path "$parent" -Force | Out-Null
    }
    if (-not (Test-Path -LiteralPath "$destDir")) {
        New-Item -ItemType Directory -Path "$destDir" -Force | Out-Null
    }

    # Copy all files from source skill folder to dest (LiteralPath + quoted handling)
    Write-Host "Installing skill '$targetName' to `"$destDir`"..."
    Copy-Item -LiteralPath "$sourceDir" -Destination "$destDir" -Recurse -Force
    # Copy-Item with directory source copies the folder itself; ensure SKILL.md ends up at dest/SKILL.md
    # If Copy-Item created nested folder, handle flatten: check if "$destDir/$targetName" exists
    $nested = Join-Path -Path "$destDir" -ChildPath "$targetName"
    if (Test-Path -LiteralPath "$nested") {
        Get-ChildItem -LiteralPath "$nested" -Force | ForEach-Object {
            Move-Item -LiteralPath "$($_.FullName)" -Destination "$destDir" -Force
        }
        Remove-Item -LiteralPath "$nested" -Force -Recurse -ErrorAction SilentlyContinue
    }

    Write-Host "Installed '$targetName' to `"$destDir`""
    exit 0
}

if ($core -or $all) {
    # Core categories to install globally
    $coreCategories = @("design", "workflow", "build", "quality", "review", "security", "performance", "productivity", "meta", "devops", "_catalog")
    $globalRoot = Join-Path -Path $HOME -ChildPath ".config/opencode/skills"
    # Also support $env:USERPROFILE on Windows if HOME not set
    if (-not $HOME -or $HOME -eq "") {
        $globalRoot = Join-Path -Path $env:USERPROFILE -ChildPath ".config/opencode/skills"
    }

    if ($dryRun) {
        Write-Host "[dryRun] Would install Core skills to `"$globalRoot`""
        foreach ($cat in $coreCategories) {
            $src = Join-Path -Path "skills" -ChildPath "$cat"
            if (Test-Path -LiteralPath "$src") {
                $dest = Join-Path -Path "$globalRoot" -ChildPath "$cat"
                Write-Host "[dryRun] Robocopy `"$src`" `"$dest`" /E"
                # List skills under this category
                $catSkills = Get-ChildItem -LiteralPath "$src" -Recurse -Filter "SKILL.md" -File -ErrorAction SilentlyContinue
                foreach ($cs in $catSkills) {
                    Write-Host "  [dryRun] would copy $($cs.Directory.Name) from `"$($cs.Directory.FullName)`""
                }
            } else {
                Write-Host "[dryRun] skip $cat -- no source at `"$src`""
            }
        }
        if ($all) {
            Write-Host "[dryRun] Would merge opencode.json skills: [`"C:/Users/srija/.config/opencode/crazy-skills/skills`"]"
        }
        exit 0
    }

    # Ensure global root exists
    if (-not (Test-Path -LiteralPath "$globalRoot")) {
        New-Item -ItemType Directory -Path "$globalRoot" -Force | Out-Null
    }

    foreach ($cat in $coreCategories) {
        $src = Join-Path -Path "skills" -ChildPath "$cat"
        if (-not (Test-Path -LiteralPath "$src")) {
            Write-Host "Skipping $cat -- no source at `"$src`""
            continue
        }
        $dest = Join-Path -Path "$globalRoot" -ChildPath "$cat"
        Write-Host "Installing Core category '$cat' from `"$src`" to `"$dest`"..."
        if (-not (Test-Path -LiteralPath "$dest")) {
            New-Item -ItemType Directory -Path "$dest" -Force | Out-Null
        }
        # Use Robocopy if available, else fallback to Copy-Item
        $robocopy = Get-Command robocopy -ErrorAction SilentlyContinue
        if ($robocopy) {
            # Robocopy requires quoted paths already handled; use call operator
            & robocopy "`"$src`"" "`"$dest`"" /E /NFL /NDL /NJH /NJS /R:1 /W:1 | Out-Null
            $rc = $LASTEXITCODE
            # Robocopy exit codes 0-7 are success, 8+ are failures
            if ($rc -ge 8) {
                Write-Error "Robocopy failed for $cat (exit $rc)"
                exit 1
            }
        } else {
            # Fallback for non-Windows or missing robocopy
            Copy-Item -LiteralPath "$src" -Destination "$dest" -Recurse -Force
        }
    }
    Write-Host "Core install complete to `"$globalRoot`""

    if ($all) {
        $opencodeJsonPath = "opencode.json"
        $desiredSkillPath = "C:/Users/srija/.config/opencode/crazy-skills/skills"
        # Also handle alternative path with forward slashes vs backslashes; keep as specified
        if (-not (Test-Path -LiteralPath "$opencodeJsonPath")) {
            Write-Error "opencode.json not found at `"$opencodeJsonPath`""
            exit 1
        }
        $jsonRaw = Get-Content -LiteralPath "$opencodeJsonPath" -Raw -ErrorAction Stop
        try {
            $obj = $jsonRaw | ConvertFrom-Json -ErrorAction Stop
        } catch {
            Write-Error "Failed to parse opencode.json: $($_.Exception.Message)"
            exit 1
        }
        # Ensure skills property exists and is array
        if (-not $obj.PSObject.Properties['skills']) {
            $obj | Add-Member -MemberType NoteProperty -Name "skills" -Value @()
        }
        if ($null -eq $obj.skills) { $obj.skills = @() }
        # Normalize to array
        $skillsArray = @($obj.skills)
        if ($skillsArray -notcontains $desiredSkillPath) {
            $skillsArray += "$desiredSkillPath"
            $obj.skills = $skillsArray
            $newJson = $obj | ConvertTo-Json -Depth 10
            Set-Content -LiteralPath "$opencodeJsonPath" -Value $newJson -Encoding UTF8
            Write-Host "Merged opencode.json skills to include `"$desiredSkillPath`""
        } else {
            Write-Host "opencode.json already contains `"$desiredSkillPath`""
        }
    }
    exit 0
}

# No actionable switch -- show usage
Write-Host "Usage: pwsh ./scripts/install.ps1 [--list] [--core] [--all] [--pick <name>] [--dryRun]"
Write-Host "  --list          Enumerate available skill names"
Write-Host "  --core          Install Core skills to `$HOME/.config/opencode/skills/ (Robocopy)"
Write-Host "  --pick <name>   Install single skill to ./.opencode/skills/<name>/"
Write-Host "  --all           Do --core plus merge opencode.json skills array"
Write-Host "  --dryRun        Print what would be done without copying"
exit 0
