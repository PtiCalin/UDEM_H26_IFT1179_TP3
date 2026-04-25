param(
    [string]$ReadmePath = "README.md",
    [string]$ChangelogPath = "CHANGE-LOG.md"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -Path $ReadmePath)) {
    throw "README not found: $ReadmePath"
}
if (-not (Test-Path -Path $ChangelogPath)) {
    throw "Changelog not found: $ChangelogPath"
}

$readme = Get-Content -Path $ReadmePath -Raw
$changelogLines = Get-Content -Path $ChangelogPath

$startMarker = "<!-- LATEST-CHANGES:START -->"
$endMarker = "<!-- LATEST-CHANGES:END -->"

if (-not $readme.Contains($startMarker) -or -not $readme.Contains($endMarker)) {
    $readme = $readme.TrimEnd() + "`n`n## Latest Changes`n`n$startMarker`n$endMarker`n"
}

$unreleasedIndex = [Array]::IndexOf($changelogLines, "## [Unreleased]")
if ($unreleasedIndex -lt 0) {
    throw "Missing '## [Unreleased]' in changelog"
}

$nextVersionIndex = -1
for ($i = $unreleasedIndex + 1; $i -lt $changelogLines.Count; $i++) {
    if ($changelogLines[$i].StartsWith("## [")) {
        $nextVersionIndex = $i
        break
    }
}
if ($nextVersionIndex -lt 0) {
    $nextVersionIndex = $changelogLines.Count
}

$block = $changelogLines[$unreleasedIndex..($nextVersionIndex - 1)]
$filtered = @()
foreach ($line in $block) {
    if ($line.Trim() -eq "-") { continue }
    $filtered += $line
}

$snippet = @(
    "### Snapshot from Changelog",
    "",
    "_Last sync: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') UTC_",
    ""
) + $filtered

$replacement = $startMarker + "`n" + ($snippet -join "`n") + "`n" + $endMarker
$pattern = [regex]::Escape($startMarker) + ".*?" + [regex]::Escape($endMarker)
$newReadme = [regex]::Replace($readme, $pattern, $replacement, [System.Text.RegularExpressions.RegexOptions]::Singleline)

if ($newReadme -ne $readme) {
    Set-Content -Path $ReadmePath -Value $newReadme
    Write-Host "Updated $ReadmePath"
} else {
    Write-Host "No README changes needed"
}
