# Branches

## Purpose

This document defines how to create and use branches so that project history stays readable and version-ready.

## Branch Types

- `main`: production-ready or submission-ready state only.
- `feature/*`: new features, modules, or substantial additions.
- `fix/*`: bug fixes and corrective changes.
- `docs/*`: report writing, references, and documentation updates.
- `chore/*`: maintenance (formatting, tooling, cleanup).
- `release/*` (optional): release preparation for milestone or final hand-in.

## Naming Rules

- Use lowercase.
- Use hyphens, not spaces.
- Keep names short and explicit.

Pattern:

- `<type>/<scope>-<purpose>`

Examples:

- `feature/data-preprocessing`
- `fix/figure-label-overlap`
- `docs/final-discussion-draft`
- `release/v0.3.0`

## Creation Flow

1. Sync local `main` with remote.
2. Create a branch from `main`.
3. Commit focused changes.
4. Open one pull request per branch.
5. Merge, then delete the branch.

## Rules

- No direct push to `main`.
- One topic per branch.
- Keep branch lifetime short.
- Rebase or merge `main` into long-lived branches regularly.

## School Project Recommendations

- Use `feature/*` for implementation tasks.
- Use `docs/*` for report sections and references.
- Create `release/*` before each major milestone submission.
