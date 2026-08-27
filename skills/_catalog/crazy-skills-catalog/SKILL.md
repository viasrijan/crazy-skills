---
name: crazy-skills-catalog
description: "Use when you need a skill not in Core, want to browse all 60+ extended skills, or don't know which skill fits — discover and install on demand."
---

# Crazy Skills Catalog

Discover and install any Extended skill on demand. Core (18 skills) is always advertised; this catalog is the gateway to the remaining 40+.

## When to use

- You need a skill not in Core (e.g., `readme-generation`, `voltagent-observability`, `adverse-review`)
- You want to browse the full library by category
- You don't know which skill fits — search the table

## Workflow

1. **Find** — Scan the table below (or `docs/CATALOG.md` for the full auto-generated index).
2. **Pick** — Choose the skill name.
3. **Install** — In a terminal at the repo or project root:
   ```powershell
   .\scripts\install.ps1 --pick <skill-name>          # current project → .opencode/skills/<name>/
   .\scripts\install.ps1 --pick <skill-name> --dryRun # preview
   ```
   Or globally: `.\scripts\install.ps1 --all` (adds `skills` array to `opencode.json`).

## Catalog (Core + Extended — grouped by hybrid category)

> This table is a summary. The canonical auto-generated index is `docs/CATALOG.md` (run `.\scripts\generate-catalog.ps1` after any skill change).

| Category | Skill | Tier | Purpose | Install |
|---|---|---|---|---|
| design | `frontend-design` | Core | Production-grade UI generation (anthropics 818k + vercel guidelines) | — (Core) |
| design | `system-architecture` | Core | Microservices/scalability review | — (Core) |
| workflow | `brainstorming` | Core | Socratic idea → sectioned design doc | — (Core) |
| workflow | `writing-plans` | Core | Spec → 2-5 min executable plan | — (Core) |
| workflow | `executing-plans` | Core | Execute plan in parallel session | — (Core) |
| workflow | `dispatching-parallel-agents` | Core | Delegate independent tasks concurrently | — (Core) |
| workflow | `finishing-a-development-branch` | Core | Verify → present merge/PR options → cleanup | — (Core) |
| build | `subagent-driven-development` | Core | One subagent per task + 2-stage review | — (Core) |
| quality | `test-driven-development` | Core | RED-GREEN-REFACTOR, pyramid 80/15/5 | — (Core) |
| quality | `systematic-debugging` | Core | 4-phase root-cause Iron Law | — (Core) |
| quality | `verification-before-completion` | Core | Fresh verification before any success claim | — (Core) |
| review | `requesting-code-review` | Core | Dispatch code-reviewer subagent | — (Core) |
| review | `receiving-code-review` | Core | Verify feedback before implementing | — (Core) |
| security | `security-and-hardening` | Core | OWASP Top 10, auth, secrets | — (Core) |
| performance | `performance-optimization` | Core | Measure-first, bundle, Core Web Vitals | — (Core) |
| performance | `core-web-vitals` | Core | LCP ≤2.5s, INP ≤200ms, CLS ≤0.1 | — (Core) |
| productivity | `token-efficiency` | Core | Bash over Read, model routing (90-95% saving) | — (Core) |
| productivity | `prompt-enhancement` | Core | RSCIT auto-enhance input prompts (always-on) | — (Core) |
| devops | `using-git-worktrees` | Core | Isolated worktree + setup | — (Core) |
| devops | `git-workflow-and-versioning` | Core | Trunk-based, atomic commits | — (Core) |
| meta | `using-crazy-skills` | Core | How to find and use Crazy Skills | — (Core) |
| meta | `writing-skills` | Core | TDD for process docs | — (Core) |
| _catalog | `crazy-skills-catalog` | Core | This index — browse Extended | — (Core) |
| docs | `readme-generation` | Extended | High-converting README + badges + SVG logo | `install.ps1 --pick readme-generation` |
| docs | `documentation-and-adrs` | Extended | ADRs, API docs, why-not-what | `install.ps1 --pick documentation-and-adrs` |
| productivity | `context-compression` | Extended | 3-layer Micro/Auto/Full Compact (30/60/85%) | `install.ps1 --pick context-compression` |
| data | `voltagent-best-practices` | Extended | Agents vs workflows, memory, observability | `install.ps1 --pick voltagent-best-practices` |
| data | `voltagent-core-reference` | Extended | VoltAgent API reference | `install.ps1 --pick voltagent-core-reference` |
| review | `adverse-review` | Extended | 3-persona adversarial review | `install.ps1 --pick adverse-review` |
| ... | ... | Extended | See `docs/CATALOG.md` for remaining 30+ | `install.ps1 --pick <name>` |

## Verification

- After `--pick`, confirm: `Test-Path .opencode/skills/<name>/SKILL.md` → True
- Run: `.\scripts\audit-skills.ps1 --skill <category>/<name>` → PASS
- Next turn, the skill is discoverable via the `skill` tool.
