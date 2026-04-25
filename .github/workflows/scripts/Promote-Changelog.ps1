param(
    [Parameter(Mandatory = $true)][string]$Version,
    [string]$Date = "",
    [string]$ChangelogPath = "CHANGE-LOG.md"
)

$ErrorActionPreference = "Stop"

if (-not $Date) {
    $Date = Get-Date -Format "yyyy-MM-dd"
}
if (-not (Test-Path -Path $ChangelogPath)) {
    throw "Changelog not found: $ChangelogPath"
}

$lines = [System.Collections.Generic.List[string]]::new()
(Get-Content -Path $ChangelogPath) | ForEach-Object { [void]$lines.Add($_) }

$version = $Version.TrimStart("v")
$newHeader = "## [$version] - $Date"

$existingVersionIndex = $lines.FindIndex({ param($l) $l -eq $newHeader })
if ($existingVersionIndex -ge 0) {
    Write-Host "Version already exists in changelog: $newHeader"
    exit 0
}

$unreleasedIndex = $lines.FindIndex({ param($l) $l -eq "## [Unreleased]" })
if ($unreleasedIndex -lt 0) {
    throw "Missing '## [Unreleased]' section"
}

$nextVersionIndex = $lines.FindIndex($unreleasedIndex + 1, { param($l) $l.StartsWith("## [") })
if ($nextVersionIndex -lt 0) {
    $nextVersionIndex = $lines.Count
}

$unreleasedContent = @()
for ($i = $unreleasedIndex + 1; $i -lt $nextVersionIndex; $i++) {
    $line = $lines[$i]
    if ($line.Trim() -eq "-") { continue }
    $unreleasedContent += $line
}

$emptyTemplate = @(
    "## [Unreleased]",
    "",
    "### Added",
    "",
    "- ",
    "",
    "### Changed",
    "",
    "- ",
    "",
    "### Deprecated",
    "",
    "- ",
    "",
    "### Removed",
    "",
    "- ",
    "",
    "### Fixed",
    "",
    "- ",
    "",
    "### Security",
    "",
    "- "
)

$versionBlock = @($newHeader, "") + $unreleasedContent

$prefix = $lines.GetRange(0, $unreleasedIndex)
$suffix = $lines.GetRange($nextVersionIndex, $lines.Count - $nextVersionIndex)

$newLines = [System.Collections.Generic.List[string]]::new()
$prefix | ForEach-Object { [void]$newLines.Add($_) }
$emptyTemplate | ForEach-Object { [void]$newLines.Add($_) }
[void]$newLines.Add("")
$versionBlock | ForEach-Object { [void]$newLines.Add($_) }
[void]$newLines.Add("")
$suffix | ForEach-Object { [void]$newLines.Add($_) }

Set-Content -Path $ChangelogPath -Value $newLines
Write-Host "Promoted Unreleased changes to $newHeader"
