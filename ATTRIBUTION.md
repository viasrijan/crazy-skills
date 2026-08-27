# Attribution

This repo composes the best parts of upstream skills. Every canonical `SKILL.md` cites its sources in its footer; this file is the repo-level record.

## Upstream Sources (pinned in `scripts/sources.json`)

| Source ID | Repo | Branch | License | Author | Use |
|---|---|---|---|---|---|
| `superpowers` | [`obra/superpowers`](https://github.com/obra/superpowers) | `main` | MIT | obra (Jesse Vincent) | Workflow backbone (brainstorming → plan → execute → review), TDD, debugging, worktrees |
| `voltagent` | [`VoltAgent/skills`](https://github.com/VoltAgent/skills) | `main` | MIT | VoltAgent | `create-voltagent`, `voltagent-best-practices`, `voltagent-core-reference`, `voltagent-docs-bundle` |
| `addy-agent` | [`addyosmani/agent-skills`](https://github.com/addyosmani/agent-skills) | `main` | MIT | Addy Osmani | 24 skills: interview → spec → TDD → security/perf/git/ci/docs/observability |
| `addy-web-quality` | [`addyosmani/web-quality-skills`](https://github.com/addyosmani/web-quality-skills) | `main` | MIT | Addy Osmani | `web-quality-audit`, `performance`, `core-web-vitals`, `accessibility`, `seo`, `best-practices` |
| `addy-adverse` | [`addyosmani/adverse`](https://github.com/addyosmani/adverse) | `main` | MIT | Addy Osmani | `adverse-review` (3-persona) |
| `alireza` | [`alirezarezvani/claude-skills`](https://github.com/alirezarezvani/claude-skills) | `main` | MIT | Alireza Rezvani | 386 skills: engineering-team, POWERFUL (agent-designer, mcp-builder, tech-debt-tracker, etc.) |
| `readme` | [`d-o-hub/github-template-ai-agents`](https://github.com/d-o-hub/github-template-ai-agents) | `main` | MIT | d-o-hub | `readme-best-practices` (badges, SVG logo, audit) |
| `prompt-enhancer` | [`brixtonpham/claude-config`](https://github.com/brixtonpham/claude-config) | `main` | MIT | brixtonpham | `prompt-enhancer` |
| `llm-prompt-optimizer` | [`mohamednaeem92-max/OPENCODE-6-2026`](https://github.com/mohamednaeem92-max/OPENCODE-6-2026) | `main` | MIT | mohamednaeem92-max | `llm-prompt-optimizer` RSCIT |
| `token-efficiency` | [`Delphine-L/claude_global`](https://github.com/Delphine-L/claude_global) | `main` | MIT | Delphine-L | `token-efficiency` |
| `context-compression` | [`guanyang/antigravity-skills`](https://github.com/guanyang/antigravity-skills) | `main` | MIT | guanyang | `context-compression` 3-layer |
| `anthropics` | [`anthropics/skills`](https://github.com/anthropics/skills) | `main` | Apache-2.0 | Anthropic | `frontend-design` |
| `vercel` | [`vercel-labs/agent-skills`](https://github.com/vercel-labs/agent-skills) | `main` | MIT | Vercel | `vercel-react-best-practices`, `web-design-guidelines` |

Commit SHAs are pinned at `main` head at time of `scripts/sync-upstream.ps1 --apply`; run that script to materialize SHAs. All licenses are MIT or Apache-2.0 (compatible).

## Skill-to-Source Mapping (53 skills, 2026-08-26)

| Skill | Category | Source(s) | License |
|---|---|---|---|
| `frontend-design` | design | `anthropics/skills` frontend-design + `vercel-labs` web-design-guidelines | MIT / Apache-2.0 |
| `system-architecture` | design | `alirezarezvani` senior-architect + api-design-reviewer | MIT |
| `brainstorming` | workflow | `obra/superpowers` | MIT |
| `writing-plans` | workflow | `obra/superpowers` + `addyosmani` planning-and-task-breakdown | MIT |
| `executing-plans` | workflow | `obra/superpowers` | MIT |
| `dispatching-parallel-agents` | workflow | `obra/superpowers` | MIT |
| `finishing-a-development-branch` | workflow | `obra/superpowers` | MIT |
| `subagent-driven-development` | build | `obra/superpowers` | MIT |
| `test-driven-development` | quality | `obra/superpowers` + `addyosmani` tdd + `mattpocock` | MIT |
| `systematic-debugging` | quality | `obra/superpowers` + `addyosmani` debugging-and-error-recovery | MIT |
| `verification-before-completion` | quality | `obra/superpowers` | MIT |
| `requesting-code-review` | review | `obra/superpowers` | MIT |
| `receiving-code-review` | review | `obra/superpowers` | MIT |
| `security-and-hardening` | security | `addyosmani` security-and-hardening + `alirezarezvani` tresor secret-scanner | MIT |
| `performance-optimization` | performance | `addyosmani` performance-optimization + `vercel-labs` | MIT |
| `core-web-vitals` | performance | `addyosmani/web-quality-skills` core-web-vitals | MIT |
| `token-efficiency` | productivity | `Delphine-L/claude_global` token-efficiency | MIT |
| `prompt-enhancement` | productivity | `brixtonpham` prompt-enhancer + `llm-prompt-optimizer` RSCIT | MIT |
| `context-compression` | productivity | `guanyang/antigravity-skills` context-compression | MIT |
| `using-git-worktrees` | devops | `obra/superpowers` | MIT |
| `git-workflow-and-versioning` | devops | `addyosmani` git-workflow-and-versioning | MIT |
| `using-crazy-skills` | meta | `obra/superpowers` using-superpowers (ported) | MIT |
| `writing-skills` | meta | `obra/superpowers` | MIT |
| `crazy-skills-catalog` | _catalog | `viasrijan/crazy-skills` (original) | MIT |
| `readme-generation` | docs | `d-o-hub` readme-best-practices + `github/awesome-copilot` blueprint | MIT |
| `documentation-and-adrs` | docs | `addyosmani` documentation-and-adrs | MIT |
| `voltagent-best-practices` | extended | `VoltAgent/skills` | MIT |
| `voltagent-core-reference` | extended | `VoltAgent/skills` | MIT |
| `create-voltagent` | extended | `VoltAgent/skills` | MIT |
| `voltagent-docs-bundle` | extended | `VoltAgent/skills` | MIT |
| `adverse-review` | extended | `addyosmani/adverse` | MIT |
| `browser-testing-with-devtools` | extended | `addyosmani` browser-testing-with-devtools | MIT |
| `web-quality-audit` | extended | `addyosmani/web-quality-skills` web-quality-audit | MIT |
| `accessibility` | extended | `addyosmani/web-quality-skills` accessibility | MIT |
| `seo` | extended | `addyosmani/web-quality-skills` seo | MIT |
| `performance` | extended | `addyosmani/web-quality-skills` performance | MIT |
| `best-practices` | extended | `addyosmani/web-quality-skills` best-practices | MIT |
| `observability-and-instrumentation` | extended | `addyosmani` observability-and-instrumentation | MIT |
| `ci-cd-and-automation` | extended | `addyosmani` ci-cd-and-automation | MIT |
| `api-and-interface-design` | extended | `addyosmani` api-and-interface-design | MIT |
| `frontend-ui-engineering` | extended | `addyosmani` frontend-ui-engineering | MIT |
| `incremental-implementation` | extended | `addyosmani` incremental-implementation | MIT |
| `interview-me` | extended | `addyosmani` interview-me | MIT |
| `idea-refine` | extended | `addyosmani` idea-refine | MIT |
| `spec-driven-development` | extended | `addyosmani` spec-driven-development | MIT |
| `planning-and-task-breakdown` | extended | `addyosmani` planning-and-task-breakdown | MIT |
| `context-engineering` | extended | `addyosmani` context-engineering | MIT |
| `source-driven-development` | extended | `addyosmani` source-driven-development | MIT |
| `doubt-driven-development` | extended | `addyosmani` doubt-driven-development | MIT |
| `agent-designer` | extended | `alirezarezvani` POWERFUL agent-designer | MIT |
| `mcp-server-builder` | extended | `alirezarezvani` POWERFUL mcp-server-builder | MIT |
| `tech-debt-tracker` | extended | `alirezarezvani` POWERFUL tech-debt-tracker | MIT |
| `canvas-design` | extended | `anthropics/skills` canvas-design | Apache-2.0 |

Per-skill footers repeat the source and link. To update SHAs: `.\scripts\sync-upstream.ps1 --apply` then `.\scripts\generate-catalog.ps1`.
