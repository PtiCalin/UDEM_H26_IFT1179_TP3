# Versionning Guidelines

Status: Official reference document for branching and versionning in this repository.

Scope: This file is the single source of truth. If another file contains overlapping rules, this document takes precedence.

## Guideline Map

- Branching rules: `BRANCHES.md`
- Commit rules: `COMMITS.md`
- Pull request rules: `PULL-REQUESTS.md`
- Release rules: `RELEASES.md`
- CLI automation usage: `CLI-AUTOMATION.md`

This guide explains how to use branches for clean versioning in this school project.

## Goals

- Keep `main` always stable and presentable.
- Make each change traceable to one branch and one pull request.
- Produce clear release points for milestones and final submission.

## Branching Model

- `main`: stable branch containing validated work only.
- `feature/*`: new functionality or significant project additions.
- `fix/*`: bug fixes.
- `docs/*`: report, references, and documentation updates.
- `chore/*`: maintenance tasks (tooling, formatting, cleanup).

Optional (for larger teams):

- `release/*`: release preparation branch before a milestone or final hand-in.

## Naming Convention

Use lowercase and hyphens:

- `feature/data-cleaning-pipeline`
- `fix/login-validation-error`
- `docs/final-report-outline`
- `release/v1.0.0`

Recommended format:

- `<type>/<short-scope>-<short-purpose>`

Examples:

- `feature/literature-review-table`
- `fix/results-chart-labels`
- `docs/methodology-citations`

## Versioning Guideline

Use semantic-style versions for project milestones:

- `MAJOR` (`v2.0.0`): major restructuring or breaking project changes.
- `MINOR` (`v1.1.0`): new features, new sections, or notable additions.
- `PATCH` (`v1.1.1`): corrections, typo fixes, small bug fixes.

Typical school project progression:

- `v0.1.0`: initial structure and setup
- `v0.2.0`: first complete draft
- `v0.3.0`: revised draft after feedback
- `v1.0.0`: final submission

## Workflow (Branch to Version)

1. Create a branch from `main` using the naming rules.
2. Commit in small, focused steps.
3. Open a pull request and complete the PR template.
4. Review and merge into `main`.
5. Update `CHANGE-LOG.md` under `Unreleased` during work.
6. At milestone/release time:
	- Move entries from `Unreleased` to a new version section.
	- Create a version tag (example: `v0.3.0`, `v1.0.0`).

## Pull Request Requirements

- Minimum one reviewer (or one self-review checklist if working solo).
- PR template must be completed.
- No direct push to `main`.
- Keep PR scope focused (one topic per PR).
- Link PR to related issue when possible.

## Commit Standards

Use conventional commits:

- `feat: add preprocessing script`
- `fix: correct reference formatting`
- `docs: update methodology section`
- `test: add unit tests for parser`

Commit-to-version mapping:

- `feat` usually contributes to `MINOR`
- `fix` usually contributes to `PATCH`
- `docs`, `chore`, `test` usually contribute to `PATCH` or no version bump
