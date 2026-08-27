---
name: documentation-and-adrs
description: "Use when making architectural decisions, changing APIs, or shipping features — write Architecture Decision Records and API docs that capture the why."
---

# Documentation and ADRs

ADR and API docs. From `addyosmani/agent-skills` `documentation-and-adrs`.

## When to use

- Making an architectural decision or changing a public API
- Shipping a feature that needs decision history

## Workflow

1. **Capture decision** — Write ADR to `docs/adr/NNNN-<slug>.md` (Number, Title, Context, Decision, Consequences, Alternatives). Keep one decision per ADR.
2. **API docs** — If API changed, update `docs/api/` with contract, error semantics, and boundary validation (Hyrum's Law, One-Version Rule).
3. **Link** — Reference ADR from the PR and from `docs/CATALOG.md` if the decision affects skills.

## Verification

- [ ] ADR follows template (Context, Decision, Consequences, Alternatives)
- [ ] API docs capture why, not just what
- [ ] ADR linked from relevant PR/docs

## References

- Source: `addyosmani/agent-skills` documentation-and-adrs
