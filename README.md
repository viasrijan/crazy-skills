# Crazy Skills

[![GitHub stars](https://img.shields.io/github/stars/viasrijan/crazy-skills?style=social)](https://github.com/viasrijan/crazy-skills) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![CI](https://img.shields.io/github/actions/workflow/status/viasrijan/crazy-skills/ci.yml?label=ci)](https://github.com/viasrijan/crazy-skills/actions) [![Skills](https://img.shields.io/badge/skills-65-brightgreen)](docs/CATALOG.md) [![OpenCode](https://img.shields.io/badge/OpenCode-native-blue)](https://opencode.ai)

> **Curated OpenCode-native skills â€” the best code from the best sectors, organized to use strategically without context overload.** 18 Core always-on, 35 Extended on demand. Two-tier smart catalog.

**Sources:** `obra/superpowers` Â· `VoltAgent/skills` Â· `addyosmani/agent-skills` Â· `alirezarezvani/claude-skills` Â· `d-o-hub/readme-best-practices` Â· `brixtonpham/claude-config` Â· Anthropic skills

---

## âœ¨ Features

| Category | Example Skills | Purpose |
|---|---|---|
| **design** | `frontend-design`, `system-architecture` | Production UI + scalability review |
| **workflow** | `brainstorming`, `writing-plans`, `executing-plans`, `dispatching-parallel-agents`, `finishing-a-development-branch` | Socratic design â†’ executable plan â†’ parallel execution |
| **build** | `subagent-driven-development` | One subagent per task + 2-stage review |
| **quality** | `test-driven-development`, `systematic-debugging`, `verification-before-completion` | RED-GREEN-REFACTOR, 4-phase debugging, evidence gate |
| **review** | `requesting-code-review`, `receiving-code-review`, `adverse-review` | Reviewer dispatch + receiving discipline + 3-persona adversarial |
| **security** | `security-and-hardening` | OWASP Top 10, secrets, dependencies |
| **performance** | `performance-optimization`, `core-web-vitals` | Measure-first, LCP/INP/CLS |
| **productivity** | `token-efficiency` (90-95%), `prompt-enhancement` (always-on RSCIT), `context-compression` | Save tokens on every turn |
| **devops** | `using-git-worktrees`, `git-workflow-and-versioning`, `ci-cd-and-automation` | Isolated worktrees, trunk-based |
| **docs** | `readme-generation`, `documentation-and-adrs` | High-converting READMEs + ADRs |
| **data/AI** | `voltagent-best-practices`, `agent-designer`, `mcp-server-builder` | VoltAgent, RAG, MCP |

Full auto-generated index: [`docs/CATALOG.md`](docs/CATALOG.md) Â· [`docs/CATALOG.json`](docs/CATALOG.json)

---

## ðŸš€ Quick Start

```powershell
git clone https://github.com/viasrijan/crazy-skills.git
cd crazy-skills

# Core â€” everyday use (23 skills â†’ ~/.config/opencode/skills/, ~3.3k tokens)
.\scripts\install.ps1 --core

# Restart OpenCode â€” skill tool now lists Core
# Use skill: "Use skill brainstorming" or "Use skill token-efficiency"

# Extended â€” per-project on demand
.\scripts\install.ps1 --pick readme-generation --dryRun  # preview
.\scripts\install.ps1 --pick readme-generation           # â†’ .opencode/skills/readme-generation/
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

## ðŸ—‚ Hybrid Taxonomy

```
skills/
â”œâ”€â”€ _catalog/crazy-skills-catalog/SKILL.md  # gateway to Extended (always Core)
â”œâ”€â”€ design/        frontend-design, system-architecture
â”œâ”€â”€ workflow/      brainstorming, writing-plans, executing-plans, dispatching-parallel-agents, finishing-a-development-branch
â”œâ”€â”€ build/         subagent-driven-development
â”œâ”€â”€ quality/       test-driven-development, systematic-debugging, verification-before-completion
â”œâ”€â”€ review/        requesting-code-review, receiving-code-review
â”œâ”€â”€ security/      security-and-hardening
â”œâ”€â”€ performance/   performance-optimization, core-web-vitals
â”œâ”€â”€ productivity/  token-efficiency, prompt-enhancement, context-compression
â”œâ”€â”€ devops/        using-git-worktrees, git-workflow-and-versioning
â”œâ”€â”€ meta/          using-crazy-skills, writing-skills
â”œâ”€â”€ docs/          readme-generation, documentation-and-adrs
â””â”€â”€ extended/      27 composites (voltagent, addy interviewâ†’spec, alireza agent/mcp/tech-debt, web-quality, etc.)
```

OpenCode discovers `SKILL.md` at **any depth** inside `skills/` â€” nested hybrid works for both `skills` array and `~/.config` copy.

---

## ðŸ”§ Scripts

| Script | Purpose | Check |
|---|---|---|
| `scripts/audit-skills.ps1` | Gate: frontmatter, headings, â‰¤500 lines, no TBD | `.\scripts\audit-skills.ps1` |
| `scripts/generate-catalog.ps1` | Rebuild `docs/CATALOG.md/.json` + catalog skill body | `.\scripts\generate-catalog.ps1 --check` |
| `scripts/install.ps1` | `--core`/`--all`/`--pick`/`--list` | `.\scripts\install.ps1 --dryRun --core` |
| `scripts/sync-upstream.ps1` | Diff pinned upstreams in `scripts/sources.json` | `.\scripts\sync-upstream.ps1 --check` |

Pinned upstreams: [`scripts/sources.json`](scripts/sources.json) (6 sources @ `main`, MIT/Apache-2.0 only). Monthly `sync --check` in CI.

---

## ðŸ“– Docs

- Design spec: [`docs/superpowers/specs/2026-08-26-crazy-skills-design.md`](docs/superpowers/specs/2026-08-26-crazy-skills-design.md)
- Plan: [`docs/superpowers/plans/2026-08-26-crazy-skills-plan.md`](docs/superpowers/plans/2026-08-26-crazy-skills-plan.md)
- Curation: [`docs/CURATION.md`](docs/CURATION.md) (Collect â†’ Score â†’ Composite â†’ Normalize â†’ Attribute)
- Attribution: [`ATTRIBUTION.md`](ATTRIBUTION.md)

---

## ðŸ¤ Contributing

1. Open an issue `skill-proposal` (sector, source URL, why canonical doesn't cover)
2. Branch `feat/<skill-name>` â†’ add `skills/<category>/<name>/SKILL.md` (template above, â‰¤500 lines)
3. `.\scripts\audit-skills.ps1 --skill <category>/<name>` + `.\scripts\generate-catalog.ps1` must pass
4. PR must cite source commit SHA and keep `docs/CATALOG.md` regenerated

---

## ðŸ“„ License

MIT Â© 2026 viasrijan â€” see [LICENSE](LICENSE). Per-skill attribution in [`ATTRIBUTION.md`](ATTRIBUTION.md) and each `SKILL.md` footer.

---

**Install count:** `npx skills add viasrijan/crazy-skills` (skills.sh) â€” coming soon. Star this repo to get release notifications.


