---
name: system-architecture
description: "Use when designing system architecture, microservices, or evaluating scalability and technology trade-offs — microservices review and risk identification."
---

# System Architecture

Microservices and system design review. Composite of `alirezarezvani/claude-skills` engineering-team `senior-architect` + POWERFUL `api-design-reviewer`.

## When to use

- Designing a new system, service boundary, or microservices split
- Reviewing an architecture for scalability, coupling, or failure modes
- Evaluating technology choices (DB, queue, infra) with trade-offs

## Workflow

1. **Map the system** — List components, data flow, dependencies, and interfaces. Draw a one-box-per-service diagram (Mermaid or ASCII).
2. **Propose 2-3 approaches** — With trade-offs (latency, cost, operational burden) and your recommendation. Ruthlessly YAGNI — remove unnecessary components.
3. **Review checklist** — For the chosen approach:
   - Boundaries: does each service have one clear purpose? Can you change internals without breaking consumers?
   - Data: ownership, consistency (eventual vs strong), schema evolution
   - Failure: retries, timeouts, circuit breakers, observability
   - Scale: stateful vs stateless, caching, partitioning
4. **Document** — Write the validated design to `docs/architecture/<topic>.md` (or `docs/superpowers/specs/` if architectural per brainstorming).

## Verification

- [ ] 2-3 approaches with trade-offs and a recommended option
- [ ] Sectioned design approved per section before committing
- [ ] Boundaries pass isolation test (change internals without breaking consumers)
- [ ] Failure and scale considerations are explicit, not deferred

## References

- Source: `alirezarezvani/claude-skills` engineering-team/senior-architect, engineering/POWERFUL/api-design-reviewer
