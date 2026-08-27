---
name: prompt-enhancement
description: "Use when enhancing or optimizing input prompts — transform vague prompts into precision instructions with RSCIT, hallucination guards, and compression to get the best results."
---

# Prompt Enhancement

Transform weak or vague prompts into precision-engineered instructions. Composite of `brixtonpham/claude-config` `prompt-enhancer` + `llm-prompt-optimizer` RSCIT.

## When to use

- Input is vague, inconsistent, or hallucination-prone
- Need structured/JSON output reliably
- Want to cut input tokens without losing effectiveness
- This skill is always-on in Crazy Skills — also wired as `UserPromptSubmit` hook for auto-enhancement

## Workflow

### 1. Diagnose

| Problem | Symptom | Fix |
|---|---|---|
| Too vague | Generic answers | Add Role + Context + Constraints |
| No structure | Unformatted | Specify output format |
| Hallucination | Confident wrong | Add "say I don't know if unsure" |
| Inconsistent | Different each run | Add few-shot examples |
| Too long | Verbose | Add length constraints |

### 2. Apply RSCIT

- **R — Role:** Who is the AI? (e.g., "senior ML engineer")
- **S — Situation:** What context? (e.g., "1 year Python, no ML background")
- **C — Constraints:** Rules and limits (e.g., "≤200 words, no formulas, use analogy")
- **I — Instructions:** What exactly to do?
- **T — Template:** What output looks like?

**Before:** `Explain machine learning.`
**After:** `You are a senior ML engineer. Context: junior with 1 year Python. Task: explain supervised ML simply. Constraints: analogy, ≤200 words, no formulas, one next step. Format: plain prose.`

### 3. Compress filler

`Please carefully analyze the following code and provide...` → `Analyze this code: explain what it does, how it works, flag issues.`

### 4. Hallucination guard

`Answer based ONLY on provided context. If not contained, respond exactly: "I don't have enough information."`

## Verification

- [ ] Role, Situation, Constraints, Instructions, Template are explicit
- [ ] Output format is explicitly defined (JSON/markdown/bullets)
- [ ] Hallucination guard present for factual tasks
- [ ] Prompt is compressed (filler removed) without losing task-critical instructions

## References

- Source: `brixtonpham/claude-config` prompt-enhancer, `mohamednaeem92-max/OPENCODE-6-2026` llm-prompt-optimizer
- Hook: `UserPromptSubmit` → prompt-enhancement (optional auto-mode in `opencode.json`)
