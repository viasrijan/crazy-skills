---
name: context-compression
description: "Use when agent sessions generate long histories, context window limits are hit, or you need to preserve decisions and artifact trails across compression."
---

# Context Compression

3-layer pipeline for long sessions. From `guanyang/antigravity-skills` `context-compression` / `agent-skills-for-context-engineering`.

## When to use

- Conversation exceeds ~50 turns or you notice context loss
- User says "compress", "compact", "too long"
- Before a complex multi-step task that needs headroom

## Workflow

Use **tokens-per-task**, not tokens-per-request — a saving that causes re-fetching costs more.

**Three layers:**

- **MicroCompact (30-40%, zero loss):** Collapse confirmations, repeated tool outputs, filler.
- **AutoCompact (60-70%, minimal loss):** Restructure into `## What We Know`, `## Decisions Made`, `## Current Task`; group file reads into summaries.
- **Full Compact (85-90%, moderate loss but recoverable):** Reduce to `## State`, `## Intent`, `## Constraints` — no snippets, just paths.

**Rules:** Never compress away decisions, arch choices, active task state; always compress greetings, superseded attempts; flag if about to drop something critical.

## Verification

- [ ] Correct layer chosen for situation (getting long → Micro, losing context → Auto, hitting limits → Full)
- [ ] Output lists before/after estimate, preserved/dropped, and asks "Does this capture everything?"
- [ ] Artifact trail (files modified) preserved in structured sections

## References

- Source: `guanyang/antigravity-skills` context-compression, `irfad7/claude-power-skills` context-compression
- See also: `productivity/token-efficiency` for per-turn savings, `productivity/prompt-enhancement` for input
