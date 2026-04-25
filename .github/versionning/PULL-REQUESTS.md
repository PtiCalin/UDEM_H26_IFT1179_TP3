# Pull requests

## Purpose

This document defines pull request standards so changes are reviewable, traceable, and safe to merge.

## Before Opening a PR

1. Ensure branch is up to date with `main`.
2. Ensure local checks or tests pass.
3. Ensure commit messages follow the commit guideline.

## PR Title Format

- `[TYPE] Short clear summary`

Examples:

- `[FEATURE] Add data ingestion pipeline`
- `[FIX] Correct report export encoding`
- `[DOCS] Update literature review section`

## PR Description Must Include

- What changed
- Why it changed
- How it was validated
- Any risk or known limitation
- Related issue/task (if available)

## Review Rules

- Minimum one review (or self-review checklist in solo mode).
- Keep PR scope focused (single topic).
- Request changes when requirements are not met.
- Merge only when required checks are complete.

## Merge Rules

- Do not merge with unresolved critical comments.
- Use squash merge when commit history is noisy.
- Delete source branch after merge.

## School Project Recommendations

- Open PRs early for milestone visibility.
- Keep report/documentation PRs separate from technical implementation PRs.
- Link PRs to changelog updates before release.
