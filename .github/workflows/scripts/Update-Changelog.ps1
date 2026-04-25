param(
    [string]$BaseBranch = "main",
    [string]$ChangelogPath = "CHANGE-LOG.md"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -Path $ChangelogPath)) {
    throw "Changelog not found: $ChangelogPath"
}

$eventName = $env:GITHUB_EVENT_NAME
$refType = $env:GITHUB_REF_TYPE
$refName = $env:GITHUB_REF_NAME
$beforeSha = $env:GITHUB_EVENT_BEFORE

$range = ""
if ($eventName -eq "push" -and $beforeSha -and $beforeSha -ne "0000000000000000000000000000000000000000") {
    $range = "$beforeSha..HEAD"
} elseif ($eventName -eq "pull_request") {
    $range = "origin/$BaseBranch...HEAD"
} else {
    $mergeBase = ""
    try {
        $mergeBase = (git merge-base "origin/$BaseBranch" HEAD 2>$null | Select-Object -First 1)
    } catch {
        $mergeBase = ""
    }

    if ($mergeBase) {
        $range = "$mergeBase..HEAD"
    } else {
        $range = "HEAD~20..HEAD"
    }
}

$logOutput = @()
try {
    $gitResult = git log --pretty=format:"%s" $range 2>&1
    if ($LASTEXITCODE -eq 0) {
        $logOutput = $gitResult
    } else {
        Write-Warning "git log failed for range '$range'. Skipping changelog update from commits."
        $logOutput = @()
    }
} catch {
    Write-Warning "git log threw an exception. Skipping changelog update from commits."
    $logOutput = @()
}

$lines = [System.Collections.Generic.List[string]]::new()
(Get-Content -Path $ChangelogPath) | ForEach-Object { [void]$lines.Add($_) }

$unreleasedIndex = $lines.FindIndex({ param($l) $l -eq "## [Unreleased]" })
if ($unreleasedIndex -lt 0) {
    throw "Missing '## [Unreleased]' section in $ChangelogPath"
}

$nextVersionIndex = $lines.FindIndex($unreleasedIndex + 1, { param($l) $l.StartsWith("## [") })
if ($nextVersionIndex -lt 0) {
    $nextVersionIndex = $lines.Count
}

$unreleasedSlice = $lines.GetRange($unreleasedIndex, $nextVersionIndex - $unreleasedIndex)

function Add-ToSection {
    param(
        [System.Collections.Generic.List[string]]$AllLines,
        [int]$SectionStart,
        [int]$SectionEnd,
        [string]$Heading,
        [string]$Entry
    )

    if ([string]::IsNullOrWhiteSpace($Entry)) {
        return $false
    }

    $bullet = "- $Entry"
    foreach ($existing in $AllLines.GetRange($SectionStart, $SectionEnd - $SectionStart)) {
        if ($existing.Trim() -eq $bullet.Trim()) {
            return $false
        }
    }

    $headingIndex = $AllLines.FindIndex($SectionStart, $SectionEnd - $SectionStart, { param($l) $l -eq "### $Heading" })
    if ($headingIndex -lt 0) {
        return $false
    }

    $insertAt = $headingIndex + 1
    while ($insertAt -lt $SectionEnd -and ($AllLines[$insertAt].Trim() -eq "" -or $AllLines[$insertAt].Trim() -eq "-")) {
        $insertAt++
    }

    $AllLines.Insert($insertAt, $bullet)
    return $true
}

$entries = @()
foreach ($subject in $logOutput) {
    if (-not $subject) { continue }
    $s = $subject.Trim()
    if ($s -eq "") { continue }

    if ($s -match "^(feat)(\(.+\))?:\s+(.+)$") {
        $entries += @{ section = "Added"; text = $Matches[3] }
        continue
    }
    if ($s -match "^(fix)(\(.+\))?:\s+(.+)$") {
        $entries += @{ section = "Fixed"; text = $Matches[3] }
        continue
    }
    if ($s -match "^(docs|refactor|perf|test|chore|ci)(\(.+\))?:\s+(.+)$") {
        $entries += @{ section = "Changed"; text = $Matches[3] }
        continue
    }
    if ($s -match "^(security)(\(.+\))?:\s+(.+)$") {
        $entries += @{ section = "Security"; text = $Matches[3] }
        continue
    }
}

if ($eventName -eq "create" -and $refType -eq "branch" -and $refName) {
    $entries += @{ section = "Changed"; text = "Branch created: $refName" }
}

$changed = $false
foreach ($entry in $entries) {
    $sectionEnd = $lines.FindIndex($unreleasedIndex + 1, { param($l) $l.StartsWith("## [") })
    if ($sectionEnd -lt 0) { $sectionEnd = $lines.Count }
    if (Add-ToSection -AllLines $lines -SectionStart $unreleasedIndex -SectionEnd $sectionEnd -Heading $entry.section -Entry $entry.text) {
        $changed = $true
    }
}

if ($changed) {
    Set-Content -Path $ChangelogPath -Value $lines
    Write-Host "Updated $ChangelogPath"
} else {
    Write-Host "No changelog updates needed"
}
