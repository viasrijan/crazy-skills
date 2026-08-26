# Crazy Skills

Curated OpenCode-native skills — the best code from the best sectors, organized to use strategically without context overload.

**Repo:** `viasrijan/crazy-skills` · **License:** MIT · **Approach:** Two-Tier Smart Catalog (18 Core always-on, 60+ Extended on demand)

> Design spec: [`docs/superpowers/specs/2026-08-26-crazy-skills-design.md`](docs/superpowers/specs/2026-08-26-crazy-skills-design.md)
> Full catalog: `docs/CATALOG.md` (auto-generated)
> Install: `.\scripts\install.ps1 --core` (Core), `--pick <skill>` (Extended), `--all` (full repo)

## Quick start

```powershell
git clone https://github.com/viasrijan/crazy-skills.git
cd crazy-skills
.\scripts\install.ps1 --core          # 18 Core → ~/.config/opencode/skills/
# or per-project: .\scripts\install.ps1 --pick readme-generation
```

After restart, `skill` tool lists Core. For Extended: `Use skill crazy-skills-catalog`.
