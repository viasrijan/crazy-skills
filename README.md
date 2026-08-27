# Crazy Skills

[![GitHub stars](https://img.shields.io/github/stars/viasrijan/crazy-skills?style=social)](https://github.com/viasrijan/crazy-skills) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![CI](https://img.shields.io/github/actions/workflow/status/viasrijan/crazy-skills/ci.yml?label=ci)](https://github.com/viasrijan/crazy-skills/actions) [![Skills](https://img.shields.io/badge/skills-53-brightgreen)](docs/CATALOG.md) [![OpenCode](https://img.shields.io/badge/OpenCode-native-blue)](https://opencode.ai)

> **Curated OpenCode-native skills — the best code from the best sectors, organized to use strategically without context overload.** 18 Core always-on, 35 Extended on demand. Two-tier smart catalog.

**Sources:** `obra/superpowers` · `VoltAgent/skills` · `addyosmani/agent-skills` · `alirezarezvani/claude-skills` · `d-o-hub/readme-best-practices` · `brixtonpham/claude-config` · Anthropic skills

---

## ✨ Features

| Category | Example Skills | Purpose |
|---|---|---|
| **design** | `frontend-design`, `system-architecture` | Production UI + scalability review |
| **workflow** | `brainstorming`, `writing-plans`, `executing-plans`, `dispatching-parallel-agents`, `finishing-a-development-branch` | Socratic design → executable plan → parallel execution |
| **build** | `subagent-driven-development` | One subagent per task + 2-stage review |
| **quality** | `test-driven-development`, `systematic-debugging`, `verification-before-completion` | RED-GREEN-REFACTOR, 4-phase debugging, evidence gate |
| **review** | `requesting-code-review`, `receiving-code-review`, `adverse-review` | Reviewer dispatch + receiving discipline + 3-persona adversarial |
| **security** | `security-and-hardening` | OWASP Top 10, secrets, dependencies |
| **performance** | `performance-optimization`, `core-web-vitals` | Measure-first, LCP/INP/CLS |
| **productivity** | `token-efficiency` (90-95%), `prompt-enhancement` (always-on RSCIT), `context-compression` | Save tokens on every turn |
| **devops** | `using-git-worktrees`, `git-workflow-and-versioning`, `ci-cd-and-automation` | Isolated worktrees, trunk-based |
| **docs** | `readme-generation`, `documentation-and-adrs` | High-converting READMEs + ADRs |
| **data/AI** | `voltagent-best-practices`, `agent-designer`, `mcp-server-builder` | VoltAgent, RAG, MCP |

Full auto-generated index: [`docs/CATALOG.md`](docs/CATALOG.md) · [`docs/CATALOG.json`](docs/CATALOG.json)

---

## 🚀 Quick Start

```powershell
git clone https://github.com/viasrijan/crazy-skills.git
cd crazy-skills

# Core — everyday use (23 skills → ~/.config/opencode/skills/, ~3.3k tokens)
.\scripts\install.ps1 --core

# Restart OpenCode — skill tool now lists Core
# Use skill: "Use skill brainstorming" or "Use skill token-efficiency"

# Extended — per-project on demand
.\scripts\install.ps1 --pick readme-generation --dryRun  # preview
.\scripts\install.ps1 --pick readme-generation           # → .opencode/skills/readme-generation/
# or browse: Use skill crazy-skills-catalog
```

**Other modes:**

```powershell
.\scripts\install.ps1 --list          # table: Category | Skill | Tier | Description
.\scripts\install.ps1 --all --dryRun  # full repo via opencode.json skills array
.\scripts\install.ps1 --pick voltagent-observability  # example niche
```

<details>
<summary>Headroom (optional 60-95% on large outputs)</summary>

```powershell
npm install @ngotrnghia1811/opencode-headroom
# add to ~/.config/opencode/opencode.json plugin array alongside superpowers
# { "plugin": ["~/.config/opencode/node_modules/superpowers", "@ngotrnghia1811/opencode-headroom"] }
```

</details>

<details>
<summary>Prompt-enhancement always-on hook (optional)</summary>

Add to `~/.config/opencode/opencode.json`:

```json
{ "hooks": { "UserPromptSubmit": [{ "matcher": "*", "hooks": [{ "type": "prompt", "prompt": "Use prompt-enhancement skill: optimize this prompt with RSCIT + compression + hallucination guard." }] }] } }
```

</details>

---

## 🗂 Hybrid Taxonomy

```
skills/
├── _catalog/crazy-skills-catalog/SKILL.md  # gateway to Extended (always Core)
├── design/        frontend-design, system-architecture
├── workflow/      brainstorming, writing-plans, executing-plans, dispatching-parallel-agents, finishing-a-development-branch
├── build/         subagent-driven-development
├── quality/       test-driven-development, systematic-debugging, verification-before-completion
├── review/        requesting-code-review, receiving-code-review
├── security/      security-and-hardening
├── performance/   performance-optimization, core-web-vitals
├── productivity/  token-efficiency, prompt-enhancement, context-compression
├── devops/        using-git-worktrees, git-workflow-and-versioning
├── meta/          using-crazy-skills, writing-skills
├── docs/          readme-generation, documentation-and-adrs
└── extended/      27 composites (voltagent, addy interview→spec, alireza agent/mcp/tech-debt, web-quality, etc.)
```

OpenCode discovers `SKILL.md` at **any depth** inside `skills/` — nested hybrid works for both `skills` array and `~/.config` copy.

---

## 🔧 Scripts

| Script | Purpose | Check |
|---|---|---|
| `scripts/audit-skills.ps1` | Gate: frontmatter, headings, ≤500 lines, no TBD | `.\scripts\audit-skills.ps1` |
| `scripts/generate-catalog.ps1` | Rebuild `docs/CATALOG.md/.json` + catalog skill body | `.\scripts\generate-catalog.ps1 --check` |
| `scripts/install.ps1` | `--core`/`--all`/`--pick`/`--list` | `.\scripts\install.ps1 --dryRun --core` |
| `scripts/sync-upstream.ps1` | Diff pinned upstreams in `scripts/sources.json` | `.\scripts\sync-upstream.ps1 --check` |

Pinned upstreams: [`scripts/sources.json`](scripts/sources.json) (6 sources @ `main`, MIT/Apache-2.0 only). Monthly `sync --check` in CI.

---

## 📖 Docs

- Design spec: [`docs/superpowers/specs/2026-08-26-crazy-skills-design.md`](docs/superpowers/specs/2026-08-26-crazy-skills-design.md)
- Plan: [`docs/superpowers/plans/2026-08-26-crazy-skills-plan.md`](docs/superpowers/plans/2026-08-26-crazy-skills-plan.md)
- Curation: [`docs/CURATION.md`](docs/CURATION.md) (Collect → Score → Composite → Normalize → Attribute)
- Attribution: [`ATTRIBUTION.md`](ATTRIBUTION.md)

---

## 🤝 Contributing

1. Open an issue `skill-proposal` (sector, source URL, why canonical doesn't cover)
2. Branch `feat/<skill-name>` → add `skills/<category>/<name>/SKILL.md` (template above, ≤500 lines)
3. `.\scripts\audit-skills.ps1 --skill <category>/<name>` + `.\scripts\generate-catalog.ps1` must pass
4. PR must cite source commit SHA and keep `docs/CATALOG.md` regenerated

---

## 📄 License

MIT © 2026 viasrijan — see [LICENSE](LICENSE). Per-skill attribution in [`ATTRIBUTION.md`](ATTRIBUTION.md) and each `SKILL.md` footer.

---

**Install count:** `npx skills add viasrijan/crazy-skills` (skills.sh) — coming soon. Star this repo to get release notifications.
