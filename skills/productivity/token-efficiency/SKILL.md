---
name: token-efficiency
description: "Use when you want to minimize token usage — efficient file reads, command execution, output handling, and model selection for cost-effective sessions."
---

# Token Efficiency

Token optimization for cost-effective sessions. From `Delphine-L/claude_global` `token-efficiency` (90-95% weekly saving) + Headroom integration.

## When to use

- Default for all sessions — apply without being asked unless user says "verbose"
- Reading log files, large outputs, codebase navigation, debugging, system status

## Workflow

**Model routing (50% saving vs all-Opus):**
- Opus: 10-15 min learning a new codebase (architecture, patterns)
- Sonnet: all implementation, debugging, routine work (default)
- Return to Opus only for deep architectural understanding or when Sonnet fails

**Reading & execution (saves 70-80% vs full reads):**
1. Prefer `Grep`/`Glob` + `Bash` filters over `Read` entire files. Example: `Grep "class Foo"`, `head -100`, `jq '.metadata'`, `head -20` for CSV + `wc -l`.
2. For exploratory searches, dispatch a `task` subagent — main context gets a paragraph back, not 40K tokens.
3. Use `--quiet`/`--silent`, `head`/`tail` sampling for large output. Skills themselves are progressive disclosure: ~155 tokens per skill at start, body loads only when triggered.

| Approach | Tokens/Week |
|---|---|
| Wasteful (Read everything) | 500K |
| Moderate (filtered reads) | 200K |
| Efficient (bash + filters + subagents) | 30-50K |

**Headroom (optional plugin):** `npm install @ngotrnghia1811/opencode-headroom` and add to `opencode.json` `plugin` — 60-95% on large tool outputs with local cache (CCR).

## Verification

- [ ] Default model is Sonnet; Opus only for learning/deep analysis
- [ ] Large files read via filters/subagents, not full `Read`
- [ ] Large command outputs sampled with `head`/`tail`/`jq`
- [ ] Skills body not assumed in-context — only frontmatter at start

## References

- Source: `Delphine-L/claude_global` token-efficiency
- See also: `productivity/prompt-enhancement` for input optimization, `productivity/context-compression` for long sessions
