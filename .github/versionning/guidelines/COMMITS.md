# Commits

## Purpose

This document defines commit style to keep history clear, reviewable, and compatible with changelog/versioning.

## Commit Format

Use conventional commits:

- `<type>: <short summary>`

Examples:

- `feat: add baseline anomaly detection module`
- `fix: correct citation export format`
- `docs: update methodology limitations section`
- `test: add regression test for parser`

## Allowed Types

- `feat`: new behavior or capability
- `fix`: bug correction
- `docs`: documentation only
- `test`: tests added or updated
- `refactor`: internal restructuring without behavior change
- `chore`: maintenance work
- `perf`: performance improvement
- `ci`: automation or pipeline updates

## Quality Rules

- Keep each commit focused on one change.
- Write imperative summaries (`add`, `fix`, `update`).
- Keep summary short and specific.
- Avoid mixing code and unrelated docs in one commit.

## Commit Granularity

- Preferred: small and coherent commits.
- Avoid: one large commit for multiple independent changes.

## Versioning Impact (Guideline)

- `feat` usually maps to `MINOR`.
- `fix` usually maps to `PATCH`.
- `docs`, `test`, `chore` usually map to `PATCH` or no bump.
