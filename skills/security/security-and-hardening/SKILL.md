---
name: security-and-hardening
description: "Use when handling user input, auth, secrets, or external integrations — prevent OWASP Top 10, enforce auth patterns, secrets management, and dependency auditing."
---

# Security and Hardening

OWASP Top 10 prevention and hardening. Composite of `addyosmani/agent-skills` `security-and-hardening` + `alirezarezvani/claude-code-tresor` `secret-scanner`/`dependency-auditor` + `trailofbits/skills`.

## When to use

- Any code touching user input, authentication, data storage, or external APIs
- Before merging changes that add dependencies or expose endpoints
- When auditing for secrets or CVEs

## Workflow

1. **Identify boundaries** — Classify trust boundaries (user → app → DB → external). Apply three-tier boundary system: validate at entry, sanitize at use, escape at output.
2. **Check OWASP Top 10** — For this change, verify:
   - Injection (SQL, XSS, command) — parameterized queries, escaping
   - Broken auth — JWT expiry, refresh, rate limit
   - Secrets — no hardcoded keys, `secret-scanner` pre-commit
   - Dependencies — `dependency-auditor` for CVEs, license compliance
3. **Apply fixes** — One fix per boundary, add failing test that demonstrates the vulnerability before fixing.
4. **Verify** — Re-run scanners, ensure 0 highs, add regression test that would fail if vulnerability returned.

## Verification

- [ ] Trust boundaries listed and each validated
- [ ] OWASP Top 10 checklist for this change has no open Highs
- [ ] Secret scan passes (no keys in diff), dependency audit passes or has plan
- [ ] Regression test for the vulnerability exists and passes

## References

- Source: `addyosmani/agent-skills` security-and-hardening, `alirezarezvani/claude-code-tresor` security/*, `trailofbits/skills`
