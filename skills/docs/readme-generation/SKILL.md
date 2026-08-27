---
name: readme-generation
description: "Use when writing, rewriting, or auditing a GitHub README.md — generate high-converting README with badges, SVG logo, and 2026 best-practice audit."
---

# README Generation

High-converting GitHub README generator. Composite of `d-o-hub/github-template-ai-agents` `readme-best-practices` + `github/awesome-copilot` `readme-blueprint-generator`.

## When to use

- User asks to "write the README", "improve README", "add badges", "make repo look professional"
- Creating a new repo and need first README
- Auditing an existing README for 2026 best practices

## Workflow

1. **Analyze repo** — `cat package.json` (or `pyproject.toml`), detect stack, list features, check existing `README.md`, `.github/` docs.
2. **Generate** — Hero: one-line SEO description + 4 badges (license, build, version, stars) + optional SVG logo (light/dark GitHub themes). Quick Start: zero-config, copy-paste runnable. Sections: Features table, Project Structure, Key Features, Development Workflow, Testing, Contributing, License.
3. **Audit** — Before finalizing, verify:
   - Logo renders both themes
   - Badges URLs valid
   - Quick Start works with zero API keys
   - Code blocks have language specifier
   - TOC anchors match headings, internal links exist
   - Description matches GitHub repo "About" field
   - Install commands cover every interface

## Verification

- [ ] README has hero + 4 badges + Quick Start in first viewport
- [ ] Badges valid, logo renders both themes
- [ ] Quick Start copy-paste runnable, all code blocks have language tag
- [ ] TOC anchors and internal links valid, description matches About

## References

- Source: `d-o-hub/github-template-ai-agents` readme-best-practices, `github/awesome-copilot` readme-blueprint-generator
