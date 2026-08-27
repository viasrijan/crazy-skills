---
name: core-web-vitals
description: "Use when diagnosing or optimizing LCP, INP, CLS — Core Web Vitals at the 75th percentile (LCP ≤2.5s, INP ≤200ms, CLS ≤0.1)."
---

# Core Web Vitals

Measured LCP/INP/CLS diagnosis. From `addyosmani/web-quality-skills` `core-web-vitals`.

## When to use

- LCP, INP, or CLS fail thresholds
- User says "improve Core Web Vitals", "fix LCP", "reduce CLS"

## Workflow

1. **Measure** — Capture field (CrUX) + lab (Lighthouse, trace) at 75th percentile for LCP, INP, CLS.
2. **Diagnose** — For the failing metric:
   - LCP: critical rendering path, server response, render-blocking, image priority
   - INP: long tasks, main-thread blocking, hydration cost
   - CLS: layout shifts, font swapping, late-injected content
3. **Optimize** — One metric at a time, keep failures separate from hypotheses (see `performance` audit).
4. **Verify** — Re-measure at p75; confirm thresholds, no regression on other metrics.

## Verification

- [ ] Baseline at p75 recorded for the failing metric
- [ ] Diagnosis maps to metric-specific cause, not generic optimization
- [ ] Fix applied to single metric, re-measured, thresholds met

## References

- Source: `addyosmani/web-quality-skills` core-web-vitals
