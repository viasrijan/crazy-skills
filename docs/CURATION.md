# Curation — How We Merge

Collect → Score → Composite → Normalize → Attribute. One canonical per trigger.

## Process

1. **Collect** — Gather candidates from pinned upstreams (see `scripts/sources.json`).
2. **Score** — Rank by signal, coverage, and license compatibility (MIT/Apache-2.0 only).
3. **Composite** — Merge best parts into one canonical skill per trigger.
4. **Normalize** — Enforce OpenCode frontmatter (name == folder, description starts `Use when`), body ≤500 lines, required sections.
5. **Attribute** — Record source repo, commit SHA, license, and author in `ATTRIBUTION.md` and skill footer.
