param(
    [string]$AttributionsPath = "ATTRIBUTIONS.md"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -Path $AttributionsPath)) {
    throw "Attributions file not found: $AttributionsPath"
}

$resourceRoots = @("files/resources", "files/assets")
$resourceFiles = @()

foreach ($root in $resourceRoots) {
    if (Test-Path -Path $root) {
        $resourceFiles += Get-ChildItem -Path $root -Recurse -File
    }
}

$extraFiles = Get-ChildItem -Path "." -Recurse -File -Include "*.bib", "*.attribution" -ErrorAction SilentlyContinue
$resourceFiles += $extraFiles

$resourceFiles = $resourceFiles | Sort-Object FullName -Unique

$entries = @()
$today = Get-Date -Format "yyyy-MM-dd"
foreach ($f in $resourceFiles) {
    $relative = Resolve-Path -LiteralPath $f.FullName -Relative
    if ($relative.StartsWith(".\\")) {
        $relative = $relative.Substring(2)
    }
    $relative = $relative.Replace("\\", "/")
    $entries += "- Resource: $relative | Source: TODO | License/Terms: TODO | Date Accessed: $today | Usage: TODO"
}

$startMarker = "<!-- AUTO-ATTRIBUTIONS:START -->"
$endMarker = "<!-- AUTO-ATTRIBUTIONS:END -->"

$content = Get-Content -Path $AttributionsPath -Raw
if (-not $content.Contains($startMarker) -or -not $content.Contains($endMarker)) {
    $append = "`n`n## Auto-Tracked Resources`n`n$startMarker`n$endMarker`n"
    $content = $content.TrimEnd() + $append
}

if ($entries.Count -eq 0) {
    $entries = @("- No auto-detected resources yet.")
}

$replacement = $startMarker + "`n" + ($entries -join "`n") + "`n" + $endMarker
$pattern = [regex]::Escape($startMarker) + ".*?" + [regex]::Escape($endMarker)
$newContent = [regex]::Replace($content, $pattern, $replacement, [System.Text.RegularExpressions.RegexOptions]::Singleline)

if ($newContent -ne $content) {
    Set-Content -Path $AttributionsPath -Value $newContent
    Write-Host "Updated $AttributionsPath"
} else {
    Write-Host "No attributions update needed"
}
