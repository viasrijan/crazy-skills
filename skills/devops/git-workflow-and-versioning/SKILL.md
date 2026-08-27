---
name: git-workflow-and-versioning
description: "Use when making any code change — trunk-based development, atomic commits, change sizing (~100 lines), and the commit-as-save-point pattern."
---

# Git Workflow and Versioning

Trunk-based development and atomic commits. From `addyosmani/agent-skills` `git-workflow-and-versioning`.

## When to use

- Making any code change (always)
- Before committing or creating a PR

## Workflow

1. **Trunk-based** — Short-lived branches, merge to `main` frequently. Keep changes ~100 lines; split larger changes with stacking or feature flags.
2. **Atomic commits** — Each commit is a save point: one logical change, tests pass, message follows conventional commits (`feat:`, `fix:`, `chore:`).
3. **Before commit** — Run the relevant verification (tests, audit) — only commit green.
4. **Push and PR** — Present options per `finishing-a-development-branch`: merge locally, push + PR, or keep.

## Verification

- [ ] Branch is short-lived and change is ~100 lines (or split)
- [ ] Commit is atomic and tests pass before commit
- [ ] Message follows conventional commits

## References

- Source: `addyosmani/agent-skills` git-workflow-and-versioning
