param(
    [switch]$check,
    [string]$source,
    [switch]$apply
)
$ErrorActionPreference = "Stop"

$sourcesPath = "scripts/sources.json"

if (-not (Test-Path -LiteralPath "$sourcesPath")) {
    Write-Error "sources.json not found at `"$sourcesPath`" -- run from repo root"
    exit 1
}

try {
    $raw = Get-Content -LiteralPath "$sourcesPath" -Raw -ErrorAction Stop
    $src = $raw | ConvertFrom-Json -ErrorAction Stop
} catch {
    Write-Error "Failed to read/parse `"$sourcesPath`": $($_.Exception.Message)"
    exit 1
}

$keys = @($src.PSObject.Properties.Name)
if (-not $keys -or $keys.Count -eq 0) {
    Write-Error "No sources defined in `"$sourcesPath`""
    exit 1
}

# If --source filter provided, validate
if ($source) {
    if ($keys -notcontains $source) {
        Write-Error "Unknown source '$source'. Available: $($keys -join ', ')"
        exit 1
    }
    $keys = @($source)
}

foreach ($k in $keys) {
    $val = $src.$k
    # Per spec, for now just print check-only line (real clone deferred)
    Write-Host "$k -> $val (check only)"
}

if ($check) {
    Write-Host "sync-upstream: check complete ($($keys.Count) source(s))"
    exit 0
}

if ($apply) {
    Write-Host "sync-upstream: --apply requested but real clone is deferred to future tasks (check only for now)"
    foreach ($k in $keys) {
        Write-Host "  would clone $($src.$k) to `$env:TEMP for $k"
    }
    exit 0
}

# Default: just printed check lines, exit 0
Write-Host "sync-upstream: done (use --check or --apply)"
exit 0
