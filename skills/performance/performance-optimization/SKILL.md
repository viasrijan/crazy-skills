---
name: performance-optimization
description: "Use when optimizing performance — measure first, then profile, bundle, and fix loading or runtime. Covers Core Web Vitals targets, profiling workflows, and React/Next.js patterns."
---

# Performance Optimization

Measure-first performance. Composite of `addyosmani/agent-skills` `performance-optimization` + `web-quality/performance` + `vercel-labs/vercel-react-best-practices` (663k).

## When to use

- Performance requirements exist or you suspect regressions
- LCP, INP, CLS are outside thresholds or bundle is large
- React/Next.js data fetching, bundle, or cache needs review

## Workflow

1. **Measure first** — Do not optimize without numbers. Collect field (CrUX/RUM) + lab (Lighthouse, trace). Record baseline: LCP, INP, CLS, bundle size, JS ≤300KB compressed.
2. **Profile** — Identify the bottleneck (critical rendering path, bundle, images, fonts, server response, N+1). Use `performance` traces, bundle analyzer, query plan.
3. **Fix the bottleneck only** — One fix at a time (code splitting, image optimization, font subsetting, caching, server response). Keep measured failures separate from hypotheses.
4. **Verify** — Re-measure with same tooling. Confirm improvement at 75th percentile, no regression elsewhere.

## Verification

- [ ] Baseline measured before any optimization
- [ ] Single bottleneck identified and fixed (not speculative batch)
- [ ] Re-measurement shows improvement, thresholds met (LCP ≤2.5s, INP ≤200ms, CLS ≤0.1 at p75)
- [ ] Bundle budgets respected: JS <300KB, CSS <100KB, above-fold images <500KB (compressed)

## References

- Source: `addyosmani/agent-skills` performance-optimization, `addyosmani/web-quality-skills` performance, `vercel-labs/agent-skills` vercel-react-best-practices
