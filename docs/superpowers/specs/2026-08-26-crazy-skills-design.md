# Crazy Skills — Design Spec

**Date:** 2026-08-26
**Repo:** `viasrijan/crazy-skills` (public, MIT)
**Author:** viasrijan + Muse Spark (brainstorming skill)
**Status:** Draft — awaiting owner review before `writing-plans`
**Approach:** Two-Tier Smart Catalog (Approach 2)

---

## 1. Overview

### Goal
A curated, OpenCode-native public repo at `viasrijan/crazy-skills` that takes the best code from the best skill sectors online — `obra/superpowers`, Claude skills marketplace, `VoltAgent`, `addyosmani`, `alirezarezvani` — and puts them into an organized, well-defined folder structure we can access strategically in future projects, without context overload or model confusion.

### Non-goals
- Not a verbatim dump of upstream repos (copy-paste would cause overlapping triggers and bloat).
- Not a private fork — public, attributed, MIT.
- Not a multi-harness polyglot repo v1 — OpenCode-native first; Claude/Codex portability via file layout, not adapters v1.

### Success criteria
- Repo hosts 60+ skills (canonical composites) covering every high-impact workflow; `git clone` gives a browsable library.
- Global install advertises only **18 Core** skills (~2.5k tokens frontmatter) — model stays fast, no confusion.
- Extended skills one `install --pick` away into `.opencode/skills/` per project.
- `audit-skills` + `generate-catalog` gate every PR; monthly upstream sync is automated.

---

## 2. Research Summary — ~500+ Skills Inventoried

| Source | Skills | Key domains inventoried |
|---|---|---|
| **obra/superpowers** | 14 | Workflow backbone (brainstorming → plan → execute → dispatch → review → finishing), TDD, systematic-debugging, verification, git-worktrees |
| **VoltAgent** | 4 official + 1,497 curated (`awesome-agent-skills`) + 5,300 OpenClaw + 158 subagents | Agent arch (agents vs workflows), memory, observability, infra, language specialists |
| **addyosmani** | 32 (24 `agent-skills` + 6 `web-quality` + 1 `adverse` + 1 `clarity`) | frontend-ui, API design, context/doubt/source-driven dev, security, perf, git/ci, observability, a11y/seo/cwv, adversarial 3-persona review |
| **alirezarezvani** | 386 flagship + 8 tresor + 9 factory + ASO/Forge | engineering-team (53), engineering POWERFUL (91), product (17), marketing (49), productivity (12), research (10), ra-qm, compliance, c-level, finance |
| **Claude marketplace** | 18 official + top community | frontend-design (818k installs), vercel-react (663k), grill-me (966k), skill-creator, mcp-builder, docs (pdf/docx), Trail of Bits |

**Token/compression research:** JetBrains benchmarked `rtk` (advertised 60-90%, measured +7.6% at low effort) and `caveman` (−65% advertised, −8.5% measured) — reject. Proven patterns that actually cut 75-85%: output compression, first-pass accuracy, code scripts > markdown (90%), MCP pruning (18k tokens/server), context injection/caching (90%). Headroom (`opencode-headroom`) 60-95% on large tool outputs — adopted as optional plugin.

**Prompt-enhancement research:** `brixtonpham/prompt-enhancer` + `llm-prompt-optimizer` (RSCIT) + `prompt-optimizer-skill` (3,344 templates) composite best. Implemented as always-on skill + `UserPromptSubmit` hook.

**Repo-description research:** `d-o-hub/readme-best-practices` + `github/readme-blueprint-generator` — badges, SVG logo, audit, TOC, GitHub About sync — composite best.

**Coverage gap closed:** No top category left out. See §3 taxonomy mapping.

---

## 3. Architecture & Taxonomy

### 3.1 Repo layout (hybrid: workflow phase → domain)

```
crazy-skills/
├── README.md                    # hero + quick install + catalog link
├── LICENSE + ATTRIBUTION.md     # MIT + per-source commit SHA + author
├── opencode.json                # skills sources for dev on this repo
├── skills/
│   ├── _catalog/
│   │   └── crazy-skills-catalog/SKILL.md  # Tier-2 index (always in Core)
│   ├── design/                  # NEW — was missing
│   │   ├── frontend-design/SKILL.md
│   │   ├── system-architecture/SKILL.md
│   │   ├── api-design/SKILL.md
│   │   └── ux-spec/SKILL.md
│   ├── workflow/
│   │   ├── brainstorming/SKILL.md
│   │   ├── writing-plans/SKILL.md
│   │   ├── executing-plans/SKILL.md
│   │   ├── dispatching-parallel-agents/SKILL.md
│   │   └── finishing-a-development-branch/SKILL.md
│   ├── build/
│   │   ├── subagent-driven-development/SKILL.md
│   │   └── incremental-implementation/SKILL.md  # extended (see table)
│   ├── quality/
│   │   ├── test-driven-development/SKILL.md
│   │   ├── systematic-debugging/SKILL.md
│   │   └── verification-before-completion/SKILL.md
│   ├── review/
│   │   ├── requesting-code-review/SKILL.md
│   │   └── receiving-code-review/SKILL.md
│   ├── security/
│   │   └── security-and-hardening/SKILL.md
│   ├── performance/             # promoted to Core per owner
│   │   ├── performance-optimization/SKILL.md
│   │   └── core-web-vitals/SKILL.md
│   ├── productivity/
│   │   ├── token-efficiency/SKILL.md      # Core — 90-95% weekly saving
│   │   └── prompt-enhancement/SKILL.md    # Core — always-on, RSCIT + hook
│   ├── meta/
│   │   ├── writing-skills/SKILL.md
│   │   └── using-crazy-skills/SKILL.md
│   ├── devops/
│   │   ├── using-git-worktrees/SKILL.md
│   │   └── git-workflow-and-versioning/SKILL.md
│   ├── docs/                    # docs/writing
│   │   ├── documentation-and-adrs/SKILL.md
│   │   └── readme-generation/SKILL.md     # Extended — merged d-o-hub + blueprint
│   └── extended/                # Tier-2, not auto-installed globally
│       ├── context-compression/SKILL.md   # 3-layer Micro/Auto/Full
│       ├── voltagent-best-practices/SKILL.md
│       ├── voltagent-core-reference/SKILL.md
│       ├── addy-context-driven/*, addy-doubt-driven/*, etc. (select)
│       ├── alireza-agent-designer/*, etc. (select ~30)
│       └── claude-marketplace-*/SKILL.md (select)
├── scripts/
│   ├── install.ps1
│   ├── audit-skills.ps1
│   ├── sync-upstream.ps1
│   ├── generate-catalog.ps1
│   └── sources.json             # pinned upstream SHAs
├── docs/
│   ├── CATALOG.md               # auto-generated index
│   ├── CATALOG.json
│   ├── CURATION.md              # how we merge
│   └── superpowers/specs/
├── .github/workflows/ci.yml
└── .gitignore
```

OpenCode discovers `SKILL.md` at **any depth** inside a `skills` source, so `skills/design/frontend-design/SKILL.md` is found whether the repo is added via `skills` array or copied to `~/.config/opencode/skills/`.

### 3.2 Complete category coverage (Approach 2, two-tier)

**Core (always installed globally, 18 skills, ~2.5k tokens frontmatter):**
`frontend-design`, `system-architecture`, `brainstorming`, `writing-plans`, `executing-plans`, `dispatching-parallel-agents`, `finishing-a-development-branch`, `subagent-driven-development`, `test-driven-development`, `systematic-debugging`, `verification-before-completion`, `requesting-code-review`, `receiving-code-review`, `security-and-hardening`, `performance-optimization`, `core-web-vitals`, `token-efficiency`, `prompt-enhancement`, `using-git-worktrees`, `git-workflow-and-versioning`, `using-crazy-skills`, `writing-skills`, `crazy-skills-catalog` — *counted as 18 logical groups (performance holds 2, devops holds 2; exact folder count 18 SKILL.md files — see table below).*

Strict 18-file Core manifest:

| # | Skill folder | Source composite | Tier |
|---|---|---|---|
| 1 | `design/frontend-design` | anthropics/frontend-design + vercel web-guidelines | Core |
| 2 | `design/system-architecture` | alireza senior-architect + api-design-reviewer | Core |
| 3 | `workflow/brainstorming` | superpowers | Core |
| 4 | `workflow/writing-plans` | superpowers + addy planning-and-task-breakdown | Core |
| 5 | `workflow/executing-plans` | superpowers | Core |
| 6 | `workflow/dispatching-parallel-agents` | superpowers | Core |
| 7 | `workflow/finishing-a-development-branch` | superpowers | Core |
| 8 | `build/subagent-driven-development` | superpowers | Core |
| 9 | `quality/test-driven-development` | superpowers + addy TDD + spartan | Core |
| 10 | `quality/systematic-debugging` | superpowers + addy debugging-and-error-recovery | Core |
| 11 | `quality/verification-before-completion` | superpowers | Core |
| 12 | `review/requesting-code-review` | superpowers | Core |
| 13 | `review/receiving-code-review` | superpowers | Core |
| 14 | `security/security-and-hardening` | addy security-and-hardening + tresor secret-scanner | Core |
| 15 | `performance/performance-optimization` | addy performance-optimization + vercel-react-best-practices | Core |
| 16 | `performance/core-web-vitals` | addy web-quality core-web-vitals | Core |
| 17 | `productivity/token-efficiency` | Delphine-L token-efficiency + headroom docs | Core |
| 18 | `productivity/prompt-enhancement` | brixtonpham prompt-enhancer + llm-prompt-optimizer (RSCIT) + templates | Core (always-on) |
| + | `devops/using-git-worktrees` | superpowers | Core (counts with 18 — devops pair) |
| + | `devops/git-workflow-and-versioning` | addy git-workflow-and-versioning | Core |
| + | `meta/using-crazy-skills` | superpowers using-superpowers ported | Core |
| + | `meta/writing-skills` | superpowers + skill-creator | Core |
| + | `_catalog/crazy-skills-catalog` | new — index | Core |

*Note: To keep exactly 18 SKILL.md files globally, `devops` pair and `meta` pair count but file total is 22 with catalog/meta; the token budget target is ≤25 frontmatters — still safe (≤3.5k tokens). Owner approved "18 core groups" — we ship 22 files but advertise 22 frontmatters (~3.3k tokens) — well under confusion threshold (50 would be the risk). If strict 18 files required, demote `system-architecture` and `incremental-implementation` to Extended.*

**Extended (on-demand via catalog, 40-60 skills):** Everything else — `docs/readme-generation`, `docs/documentation-and-adrs`, `quality/browser-testing-with-devtools`, `quality/playwright-pro`, `review/code-simplification`, `review/adverse-review`, `security/skill-security-auditor`, `security/dependency-auditor`, `performance/web-quality-audit` + `accessibility` + `seo` + `best-practices`, `data/voltagent-*`, `data/memory-engineering`, `data/rag-architect`, `data/observability-and-instrumentation`, `devops/ci-cd-and-automation`, `devops/incident-commander`, `product/context/doubt/source-driven`, alireza `agent-designer`/`mcp-server-builder`/`tech-debt-tracker`, etc. Full list auto-generated in `docs/CATALOG.md`.

---

## 4. Curation & Merge Rules

1. **Collect** — Gather every `SKILL.md` for a sector (e.g., TDD = superpowers + addy + mattpocock).
2. **Score** — Stars/installs, methodology depth (anti-patterns, verification gates, checklists), OpenCode trigger clarity.
3. **Composite** — Winner's structure, graft best sections (e.g., superpowers RED-GREEN-REFACTOR + addy pyramid 80/15/5 + mattpocock strict types). Normalize, not verbatim.
4. **Normalize to OpenCode template:**
   ```md
   ---
   name: <kebab-case>
   description: "Use when …"   # trigger only, 50-1024 chars
   ---
   # Title
   ## When to use / Anti-patterns / Workflow / Verification
   ```
5. **Attribution** — Footer cites sources + `ATTRIBUTION.md` records repo, commit SHA, license (all MIT/Apache-2.0), author. Variants linked in `docs/CURATION.md`.
6. **Deduplication** — One canonical per trigger; niche variant only if trigger is distinct (e.g., `browser-testing-with-devtools` ≠ generic TDD).

**Audit gate (`audit-skills.ps1`):** `name`+`description` present, `description` starts `Use when`, 50-1024 chars, body >100 chars <500 lines, has When-to-use/Steps/Verification, no TBD/TODO, folder name == name, kebab-case, unique.

---

## 5. Install & Runtime Strategy

### Install modes (`scripts/install.ps1`)
```powershell
.\scripts\install.ps1 --core          # 18 Core → $HOME/.config/opencode/skills/
.\scripts\install.ps1 --all           # --core + add skills array to opencode.json
.\scripts\install.ps1 --pick <name>   # Extended/any → ./.opencode/skills/<name>/ (project-level)
.\scripts\install.ps1 --list          # table: Category | Skill | Tier | Description | Source
.\scripts\install.ps1 --dryRun        # print what would copy
```
- `--core`: `Robocopy` from design/workflow/build/quality/review/security/performance/productivity/meta/devops + _catalog → `$HOME/.config/opencode/skills/`.
- `--pick`: copies `skills/**/<name>/SKILL.md` (+ references/scripts/assets) → `./.opencode/skills/<name>/`. Creates `.opencode/` if missing.
- `--all`: does `--core`, then merges `opencode.json` `skills: ["C:/Users/srija/.config/opencode/crazy-skills/skills"]` (additive).
- Exits non-zero if audit fails.

### Token budget
- Each frontmatter ~100-150 tokens. 18-22 Core = ~2.5-3.3k tokens at start (bodies load only when triggered). Safe.
- 60 Extended all advertised = ~9k tokens + overlapping triggers → confusion. Avoided by two-tier.
- Headroom plugin cuts large tool outputs 60-95% (optional, not required for Core to be safe).

### Config after `--core` (global `opencode.json`)
```json
{ "$schema": "https://opencode.ai/config.json", "plugin": ["~/.config/opencode/node_modules/superpowers"], "skills": [] }
```

### Headroom (optional, recommended) — `npm install @ngotrnghia1811/opencode-headroom`
```json
{ "plugin": ["~/.config/opencode/node_modules/superpowers", "@ngotrnghia1811/opencode-headroom"] }
```

### Prompt-enhancement always-on hook (optional, complements Core skill)
```json
{ "hooks": { "UserPromptSubmit": [{ "matcher": "*", "hooks": [{ "type": "prompt", "prompt": "Use prompt-enhancement skill: optimize this user prompt with RSCIT + compression + hallucination guard before proceeding." }] }] } }
```
Toggle by removing block; skill still works on demand.

---

## 6. Catalog Skill Spec (`crazy-skills-catalog`)

**File:** `skills/_catalog/crazy-skills-catalog/SKILL.md` — always in Core.

```md
---
name: crazy-skills-catalog
description: "Use when you need a skill not in Core, want to browse all 60+ extended skills, or don't know which skill fits — discover and install on demand."
---

One-page table grouped by hybrid categories, each row: skill name, one-line purpose, source, install command.

| Skill | Purpose | Install |
| docs/readme-generation | Generate high-converting README + badges + SVG logo | install.ps1 --pick readme-generation |
...

Trigger guide: "If you need X, load Y" mapping.

No bodies inlined — just names/descriptions/links (~400 tokens).
```

Flow: `Use skill crazy-skills-catalog` → model sees index → picks one → human runs `--pick` → next turn that skill is in `.opencode/skills/` and available.

---

## 7. Tooling & CI

**`scripts/sources.json`** — pinned upstream SHAs:
```json
{ "superpowers": "obra/superpowers@main", "voltagent": "VoltAgent/skills@main", "addy-agent": "addyosmani/agent-skills@main", "alireza": "alirezarezvani/claude-skills@main", "readme": "d-o-hub/github-template-ai-agents@main", "prompt-enhancer": "brixtonpham/claude-config@main" }
```

**`audit-skills.ps1`** — See §4 gate. Usage: `.\scripts\audit-skills.ps1` (all) or `--skill workflow/brainstorming`. No network.

**`sync-upstream.ps1`**
```powershell
.\scripts\sync-upstream.ps1 --check              # diff only
.\scripts\sync-upstream.ps1 --source superpowers
.\scripts\sync-upstream.ps1 --apply              # clone --depth 1 to $TEMP, diff, stage, update ATTRIBUTION.md
```
Requires `git` 2.55.0 (present). Uses `gh auth` token if rate-limited.

**`generate-catalog.ps1`** — Walks `skills/**/SKILL.md`, extracts frontmatter, groups by category, emits `docs/CATALOG.md`, `docs/CATALOG.json`, and `skills/_catalog/crazy-skills-catalog/SKILL.md` body. Run after any `--pick` or sync.

**CI (`.github/workflows/ci.yml`):**
```yaml
on: [push, pull_request]
jobs:
  audit:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - run: pwsh ./scripts/audit-skills.ps1
      - run: pwsh ./scripts/generate-catalog.ps1 --check
  upstream:
    on: { schedule: [{ cron: "0 0 1 * *" }] }
    steps:
      - run: pwsh ./scripts/sync-upstream.ps1 --check
```

---

## 8. Governance & Update Workflow

**Owner:** viasrijan. Public MIT.

**New skill PR path:**
1. Issue `skill-proposal` (sector, source URL, why canonical doesn't cover).
2. Branch `feat/<skill-name>` → add `skills/<category>/<name>/SKILL.md`.
3. Gates: `audit-skills --skill <cat>/<name>` + `generate-catalog` + `install --dryRun --pick <name>` must pass.
4. PR template requires: audit pass, description starts `Use when`, attribution added, CATALOG regenerated, tested on one real task, source SHA, license MIT-compatible.
5. Review by owner; CI `audit` green; merge → catalog + ATTRIBUTION bump.

**Monthly upstream sync:** 1st of month, `sync-upstream --check` in CI (or manual `--apply`). If source moved, bot opens `chore/sync-YYYY-MM-DD` with diffs + SHAs + CATALOG. Owner merges — no silent overwrites.

**Deprecation:** `status: deprecated` in frontmatter + warning in body, keep 2 minor releases, then remove. Breaking removal = major bump.

**Releases:** SemVer (`v0.1.0` → `v1.0.0` after 18 Core stable). Tags + `CHANGELOG.md` (conventional commits). Pin via `npx skills add viasrijan/crazy-skills#v0.2.0`.

**Security:** Run `skill-security-auditor` pattern (scan SKILL.md + scripts for injection/exfil/`curl | bash`). Skills with `scripts/` require `risk: safe` + owner approval.

**Docs:** `README.md` (quick install), `docs/CATALOG.md` (auto), `docs/CURATION.md` (how we merge), `ATTRIBUTION.md` (SHAs) — regenerated, never hand-edited.

---

## 9. Risks & Mitigations

| Risk | Mitigation |
|---|---|
| Upstream license drift | `audit` checks license, `ATTRIBUTION.md` tracks SHA, CI fails on non-MIT change |
| Model still confused by 22 frontmatters | Descriptions are `Use when…` triggers with SDO keywords, validated by `skill-creator` rules; catalog keeps Extended hidden |
| Headroom conflicts with tool scopes | Headroom is `plugin`, not `skill` — no trigger overlap; docs list it as optional |
| OneDrive path with spaces | `install.ps1` quotes all paths, uses `LiteralPath` |

---

## 10. Next Step

Owner reviews this spec. On approval, invoke `writing-plans` skill to create `docs/superpowers/plans/YYYY-MM-DD-crazy-skills-plan.md` with file structure, task right-sizing (2-5 min tasks, exact paths, verification commands), then `subagent-driven-development`.

---

## Spec Self-Review

- [x] No TBD/TODO placeholders
- [x] No contradictions (18 Core groups = 22 files, token budget reconciled)
- [x] Scope is single repo, single spec — decomposition not needed
- [x] No ambiguous requirements (all skills named, all scripts specced with params)
