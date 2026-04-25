# Releases

## Purpose

This document explains how to prepare and publish versions for milestones and final submission.

## Version Format

Use semantic-style tags:

- `vMAJOR.MINOR.PATCH`

Examples:

- `v0.1.0` initial setup
- `v0.2.0` first complete draft
- `v0.3.0` revised draft
- `v1.0.0` final submission

## When to Release

- End of a planned milestone
- After major feedback integration
- Before official school submission

## Release Checklist

1. Ensure `main` is stable.
2. Ensure all selected PRs are merged.
3. Update `CHANGE-LOG.md`:
	- Move items from `Unreleased` to new version section.
	- Add release date.
4. Create and push the Git tag.
5. (Optional) Create a GitHub release note from changelog entries.

## What to Include in Release Notes

- Main additions
- Important fixes
- Documentation/report changes
- Known limitations (if any)

## School Project Recommendations

- Keep one release per deliverable milestone.
- Mark final hand-in with `v1.0.0` (or course-required equivalent).
- Archive generated deliverables (PDF, slides) with each milestone release.
