---
name: frontend-design
description: "Use when building or auditing frontend UI — components, design systems, or avoiding generic AI aesthetics. Applies production-grade design principles and Vercel interface guidelines."
---

# Frontend Design

Production-grade frontend generation and audit. Composite of `anthropics/skills/frontend-design` (818k installs) + `vercel-labs/web-interface-guidelines` (576k).

## When to use

- Building or modifying any user-facing UI (React, Vue, Svelte, Next.js, Astro)
- Auditing an existing UI for Vercel Interface Guidelines violations
- Generating interfaces that must avoid generic "AI slop" aesthetics
- Reviewing design tokens, layout, or component architecture

## Workflow

### 1. Understand intent (ask one question at a time if underspecified)
- What is the UI for? Who is the user? What is the success criterion (e.g., "feels premium, not template")?

### 2. Generate / audit

**Generation path:**
- Pick a distinctive visual direction (reference `brand-guidelines` if present) — do not default to centered card + purple gradient.
- Structure with semantic layout: header, hero, feature grid, proof, CTA. Use design tokens (spacing scale, type scale, color tokens).
- Build with React + Tailwind + shadcn/ui. Keep components small and focused.
- Ensure WCAG 2.1 AA (contrast ≥4.5:1, keyboard operable, alt text).

**Audit path (Vercel guidelines):**
- Fetch `https://raw.githubusercontent.com/vercel-labs/agent-skills/main/skills/web-design-guidelines/SKILL.md` if needed and compare.
- Output violations table: `| Guideline | Severity | Location | Fix |`

### 3. Verify

- Visual: does the UI avoid the 3 generic patterns (centered hero + 3 cards, purple gradient, blob illustration)?
- Accessibility: `axe` or manual keyboard tab + contrast check.
- Tokens: spacing uses 4/8 scale, type uses capped scale, colors are semantic (not hex litter).

## Verification

- [ ] UI renders without generic AI aesthetics (distinctive direction chosen)
- [ ] WCAG AA contrast and keyboard checks pass
- [ ] Spacing/type/color use design tokens, not hardcoded values
- [ ] Audit (if run) lists violations with severity and fix

## References

- Source: `anthropics/skills` frontend-design, `vercel-labs/agent-skills` web-design-guidelines
- See also: `design/system-architecture` for non-UI architecture
