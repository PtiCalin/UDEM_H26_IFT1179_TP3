# CLI Automation Guide

This guide explains how to run the versioning automation scripts locally.

## Prerequisites

- Git repository initialized
- Windows PowerShell or PowerShell 7
- Run commands from the repository root

## Scripts

- `.github/scripts/Update-Changelog.ps1`
- `.github/scripts/Update-ReadmeChanges.ps1`
- `.github/scripts/Update-Attributions.ps1`
- `.github/scripts/Promote-Changelog.ps1`

## Recommended Local Commands

### 1) Update changelog from recent commits

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Update-Changelog.ps1
```

### 2) Sync README latest changes section from changelog

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Update-ReadmeChanges.ps1
```

### 3) Sync attributions from resources

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Update-Attributions.ps1
```

### 4) Promote Unreleased changelog to a release version

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Promote-Changelog.ps1 -Version v0.3.0
```

## One-Shot Command (Daily Use)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Update-Changelog.ps1; powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Update-ReadmeChanges.ps1; powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Update-Attributions.ps1
```

## Notes

- Scripts are idempotent: if no change is needed, they keep files unchanged.
- GitHub workflows run the same scripts automatically on push/PR/release events.
- For release tags, use `vMAJOR.MINOR.PATCH` format.
