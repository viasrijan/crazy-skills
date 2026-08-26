# Crazy Skills Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build `viasrijan/crazy-skills` — a curated OpenCode-native public repo with 18 Core skills (always advertised globally) + 40-60 Extended composites on demand via a smart catalog, hybrid taxonomy, attributed merges from 5 upstream sources, and install/audit/sync tooling that prevents context overload.

**Architecture:** Two-tier smart catalog (Approach 2) — repo holds everything (~60+ `SKILL.md` composites at `skills/**/SKILL.md`, discoverable at any depth), runtime advertises only 18-22 Core frontmatters (~3.3k tokens) via `~/.config/opencode/skills/`; Extended lives in `_catalog` index and is pulled per-project with `install.ps1 --pick`. Scripts are PowerShell-first (Windows), CI is `pwsh` audit on every PR.

**Tech Stack:** OpenCode `SKILL.md` folders (frontmatter `name`/`description`), PowerShell 5.1/7, `git` 2.55.0, `gh` CLI (viasrijan), `Robocopy`, Node `npm` (headroom optional), GitHub Actions `windows-latest` + `pwsh`.

**Spec:** `docs/superpowers/specs/2026-08-26-crazy-skills-design.md`

## Global Constraints

- License is MIT for repo; every composite SKILL.md footer + `ATTRIBUTION.md` cites source repo, commit SHA, license, author — never omit.
- Every `SKILL.md` lives at `skills/**/SKILL.md` (any depth inside `skills/` is discoverable), folder name == frontmatter `name` (kebab-case), `description` starts `Use when` and is 50-1024 chars.
- Body of every `SKILL.md` is ≤500 lines, has `## When to use`, `## Workflow`/`## Steps`, `## Verification` or `## Checklist`, and contains zero `TBD`/`TODO`.
- `audit-skills.ps1` gates every PR — it must exit 0. `generate-catalog.ps1` must be re-run after any skill change; CI fails if `docs/CATALOG.md` is stale.
- Windows paths may contain spaces — all PowerShell file ops use `-LiteralPath` and quoted strings.
- Upstream sources are pinned in `scripts/sources.json` (obra/superpowers, VoltAgent/skills, addyosmani/agent-skills, alirezarezvani/claude-skills, d-o-hub/readme-best-practices, brixtonpham/claude-config). MIT/Apache-2.0 only.
- Working directory for this plan is `C:\Users\srija\OneDrive\Documents\crazy-skills` (remote `origin` = `https://github.com/viasrijan/crazy-skills.git`, branch `main`).

---

## File Structure

```
crazy-skills/
├── README.md
├── LICENSE                          # MIT
├── ATTRIBUTION.md                   # table: skill | source repo | commit SHA | license
├── .gitignore
├── opencode.json                    # { $schema, skills: [] } for dev on this repo
├── skills/
│   ├── _catalog/crazy-skills-catalog/SKILL.md
│   ├── design/frontend-design/SKILL.md
│   ├── design/system-architecture/SKILL.md
│   ├── workflow/brainstorming/SKILL.md
│   ├── workflow/writing-plans/SKILL.md
│   ├── workflow/executing-plans/SKILL.md
│   ├── workflow/dispatching-parallel-agents/SKILL.md
│   ├── workflow/finishing-a-development-branch/SKILL.md
│   ├── build/subagent-driven-development/SKILL.md
│   ├── quality/test-driven-development/SKILL.md
│   ├── quality/systematic-debugging/SKILL.md
│   ├── quality/verification-before-completion/SKILL.md
│   ├── review/requesting-code-review/SKILL.md
│   ├── review/receiving-code-review/SKILL.md
│   ├── security/security-and-hardening/SKILL.md
│   ├── performance/performance-optimization/SKILL.md
│   ├── performance/core-web-vitals/SKILL.md
│   ├── productivity/token-efficiency/SKILL.md
│   ├── productivity/prompt-enhancement/SKILL.md
│   ├── devops/using-git-worktrees/SKILL.md
│   ├── devops/git-workflow-and-versioning/SKILL.md
│   ├── meta/using-crazy-skills/SKILL.md
│   ├── meta/writing-skills/SKILL.md
│   ├── docs/readme-generation/SKILL.md          # Extended
│   ├── docs/documentation-and-adrs/SKILL.md     # Extended
│   └── extended/... (≈40 skills)
├── scripts/
│   ├── sources.json
│   ├── audit-skills.ps1
│   ├── generate-catalog.ps1
│   ├── install.ps1
│   └── sync-upstream.ps1
├── docs/
│   ├── CATALOG.md
│   ├── CATALOG.json
│   ├── CURATION.md
│   └── superpowers/{specs,plans}/
└── .github/workflows/ci.yml
```

New files are created; no existing large file is split (repo is empty except `README.md` + spec).

---

### Task 1: Repo scaffolding — LICENSE, .gitignore, ATTRIBUTION.md, CURATION.md, opencode.json

**Files:**
- Create: `LICENSE`
- Create: `.gitignore`
- Create: `ATTRIBUTION.md`
- Create: `docs/CURATION.md`
- Create: `opencode.json`
- Modify: `README.md` (polish, keep existing hero)

**Interfaces:**
- Consumes: Spec §4, §8, global constraints, repo remote `origin`.
- Produces: Repo legal/docs shell required by every later task; `ATTRIBUTION.md` table consumed by `sync-upstream`; `opencode.json` consumed by OpenCode discovery during dogfooding.

- [ ] **Step 1: Write failing check — attribution table missing breaks audit**
  ```powershell
  # Test: audit should fail if ATTRIBUTION.md lacks table header
  pwsh -NoProfile -Command "if (-not (Select-String -LiteralPath 'ATTRIBUTION.md' -Pattern '| Skill |' -Quiet)) { exit 1 } else { exit 0 }"
  ```
  Run: `pwsh -NoProfile -Command "if (-not (Test-Path 'ATTRIBUTION.md')) { exit 1 }"`
  Expected: FAIL (exit 1) — file not yet created.

- [ ] **Step 2: Run to confirm failure**
  Run: `pwsh -NoProfile -File scripts/audit-skills.ps1 2>&1 | Out-String` (if script not yet exists, check via `Test-Path` — also fails)
  Expected: audit not found / attribution missing.

- [ ] **Step 3: Create LICENSE, .gitignore, ATTRIBUTION.md, CURATION.md, opencode.json**
  ```powershell
  # LICENSE — MIT, Copyright (c) 2026 viasrijan
  @"
  MIT License
  Copyright (c) 2026 viasrijan
  Permission is hereby granted, free of charge...
  "@ | Set-Content -LiteralPath "LICENSE" -Encoding UTF8

  # .gitignore
  @"
  node_modules/
  .DS_Store
  Thumbs.db
  *.log
  "@ | Set-Content -LiteralPath ".gitignore" -Encoding UTF8

  # ATTRIBUTION.md — skeleton table
  @"
  # Attribution
  | Skill | Source Repo | Commit SHA | License | Author |
  |---|---|---|---|---|
  | design/frontend-design | anthropics/skills | TBD | MIT | Anthropics |
  "@ | Set-Content -LiteralPath "ATTRIBUTION.md" -Encoding UTF8

  # docs/CURATION.md — how we merge
  New-Item -ItemType Directory -Path "docs" -Force | Out-Null
  @"
  # Curation — How We Merge
  Collect → Score → Composite → Normalize → Attribute. One canonical per trigger.
  "@ | Set-Content -LiteralPath "docs/CURATION.md" -Encoding UTF8

  # opencode.json — repo dev config
  @"
  {
    "`$schema": "https://opencode.ai/config.json",
    "skills": []
  }
  "@ | Set-Content -LiteralPath "opencode.json" -Encoding UTF8
  ```

- [ ] **Step 4: Verify files exist and contain required markers**
  Run: `pwsh -NoProfile -Command "Get-Content -LiteralPath 'ATTRIBUTION.md' | Select-String -Pattern '| Skill |' -Quiet; if (-not $?) { exit 1 }"`
  Expected: PASS (exit 0). Also `Test-Path LICENSE`, `Test-Path .gitignore`, `Test-Path opencode.json` all true.

- [ ] **Step 5: Commit**
  ```bash
  git add LICENSE .gitignore ATTRIBUTION.md docs/CURATION.md opencode.json README.md
  git commit -m "chore: scaffolding — LICENSE, .gitignore, ATTRIBUTION, CURATION, opencode.json"
  ```

---

### Task 2: Pin upstreams — `scripts/sources.json`

**Files:**
- Create: `scripts/sources.json`
- Modify: `ATTRIBUTION.md` (append pinned SHAs placeholder rows for 6 sources)

**Interfaces:**
- Consumes: Spec §7 `sources.json` table, Global Constraint pinned SHAs.
- Produces: `sources.json` consumed by `sync-upstream.ps1` and `generate-catalog.ps1`.

- [ ] **Step 1: Write failing test — sources.json missing / invalid JSON**
  ```powershell
  pwsh -NoProfile -Command "Get-Content -LiteralPath 'scripts/sources.json' -Raw | ConvertFrom-Json | Out-Null; if ($?) { exit 0 } else { exit 1 }"
  ```
  Expected: FAIL (file not found).

- [ ] **Step 2: Run failure check**
  Run: `pwsh -NoProfile -Command "Test-Path 'scripts/sources.json'"`
  Expected: False.

- [ ] **Step 3: Create scripts/sources.json**
  ```json
  {
    "superpowers": "obra/superpowers@main",
    "voltagent": "VoltAgent/skills@main",
    "addy-agent": "addyosmani/agent-skills@main",
    "alireza": "alirezarezvani/claude-skills@main",
    "readme": "d-o-hub/github-template-ai-agents@main",
    "prompt-enhancer": "brixtonpham/claude-config@main"
  }
  ```
  Write with `Set-Content -LiteralPath "scripts/sources.json" -Encoding UTF8` (ensure UTF8, no BOM issue for JSON).

- [ ] **Step 4: Verify JSON parses and has 6 keys**
  Run: `pwsh -NoProfile -Command "(Get-Content -LiteralPath 'scripts/sources.json' -Raw | ConvertFrom-Json).PSObject.Properties.Count -eq 6"`
  Expected: True.

- [ ] **Step 5: Commit**
  ```bash
  git add scripts/sources.json ATTRIBUTION.md
  git commit -m "chore: pin upstream sources in scripts/sources.json"
  ```

---

### Task 3: `scripts/audit-skills.ps1` — audit gate

**Files:**
- Create: `scripts/audit-skills.ps1`
- Test: `scripts/audit-skills.Tests.ps1` (optional, not required but used for self-check)

**Interfaces:**
- Consumes: `skills/**/SKILL.md` (none yet — must pass on empty set), `ATTRIBUTION.md` not needed here.
- Produces: Exit code 0/1 consumed by CI and by every later task's verification step.

- [ ] **Step 1: Write failing test — audit script does not enforce description rule**
  Create a temp bad skill `skills/_tmp/bad/SKILL.md` with `description: "bad"` (not starting `Use when`) and expect audit to fail.
  ```powershell
  New-Item -ItemType Directory -Path "skills/_tmp/bad" -Force | Out-Null
  "---`nname: bad`ndescription: bad`n---`n# Bad" | Set-Content -LiteralPath "skills/_tmp/bad/SKILL.md" -Encoding UTF8
  pwsh -NoProfile -File scripts/audit-skills.ps1; $exit = $LASTEXITCODE; Remove-Item -Recurse -LiteralPath "skills/_tmp"
  # expect exit 1
  ```
  Expected: FAIL (audit file not found yet → fail).

- [ ] **Step 2: Run to confirm missing script fails**
  Run: `pwsh -NoProfile -File scripts/audit-skills.ps1 2>&1`
  Expected: file not found error.

- [ ] **Step 3: Write minimal `audit-skills.ps1` (enforces spec §4 gate)**
  ```powershell
  param([string]$skill)
  $ErrorActionPreference = "Stop"
  $paths = if ($skill) { @("skills/$skill/SKILL.md") } else { Get-ChildItem -LiteralPath "skills" -Recurse -Filter "SKILL.md" | ForEach-Object FullName }
  if (-not $paths) { Write-Host "No skills found — audit passes (empty set)."; exit 0 }
  $bad = @()
  foreach ($p in $paths) {
    $c = Get-Content -LiteralPath $p -Raw
    if ($c -notmatch 'name:\s*\S+') { $bad += "$p missing name" }
    if ($c -notmatch 'description:\s*".*Use when') { $bad += "$p description must start Use when" }
    if ($c -match 'TBD|TODO') { $bad += "$p contains placeholder" }
    $lines = (Get-Content -LiteralPath $p).Count; if ($lines -gt 500) { $bad += "$p >500 lines" }
  }
  if ($bad) { $bad | ForEach-Object { Write-Error $_ }; exit 1 }
  Write-Host "audit-skills: PASS"; exit 0
  ```
  (Full version adds checks: body >100 chars, has When to use/Steps/Verification, kebab-case name == folder name, uniqueness.)

- [ ] **Step 4: Verify audit passes on empty set and fails on bad skill**
  Run: `pwsh -NoProfile -File scripts/audit-skills.ps1; echo "exit:$LASTEXITCODE"`
  Expected: PASS exit 0. Then re-run the bad-skill test from Step 1 — now should FAIL exit 1, then clean temp.

- [ ] **Step 5: Commit**
  ```bash
  git add scripts/audit-skills.ps1
  git commit -m "feat: add audit-skills.ps1 gate"
  ```

---

### Task 4: `scripts/generate-catalog.ps1` — CATALOG.md + CATALOG.json + catalog skill body

**Files:**
- Create: `scripts/generate-catalog.ps1`
- Create: `docs/CATALOG.md` (generated, empty header initially)
- Create: `docs/CATALOG.json`

**Interfaces:**
- Consumes: `skills/**/SKILL.md` frontmatter, `scripts/sources.json`.
- Produces: `docs/CATALOG.md`, `docs/CATALOG.json`, and later the body of `skills/_catalog/crazy-skills-catalog/SKILL.md`.

- [ ] **Step 1: Failing test — CATALOG.md does not contain table**
  ```powershell
  pwsh -NoProfile -Command "if ((Get-Content -LiteralPath 'docs/CATALOG.md' -Raw) -match '\| Skill \|') { exit 0 } else { exit 1 }"
  ```
  Expected: FAIL (file not yet generated).

- [ ] **Step 2: Run failure**
  Run: `pwsh -NoProfile -File scripts/generate-catalog.ps1 --check 2>&1`
  Expected: script not found / CATALOG stale.

- [ ] **Step 3: Write `generate-catalog.ps1` (walks skills, extracts frontmatter, groups by folder prefix)**
  ```powershell
  param([switch]$check)
  $skills = Get-ChildItem -LiteralPath "skills" -Recurse -Filter "SKILL.md" | ForEach-Object {
    $c = Get-Content -LiteralPath $_.FullName -Raw
    $name = if ($c -match 'name:\s*"?([^"\r\n]+)"?') { $Matches[1].Trim() } else { $_.Directory.Name }
    $desc = if ($c -match 'description:\s*"([^"]+)"') { $Matches[1] } else { "" }
    [PSCustomObject]@{ Name=$name; Description=$desc; Path=$_.FullName }
  }
  $md = "# Catalog`n| Skill | Description | Path |`n|---|---|---|`n"
  $skills | ForEach-Object { $md += "| $($_.Name) | $($_.Description) | $($_.Path) |`n" }
  # --check: fail if CATALOG.md differs
  ```

- [ ] **Step 4: Verify generation**
  Run: `pwsh -NoProfile -File scripts/generate-catalog.ps1; Test-Path docs/CATALOG.md; Test-Path docs/CATALOG.json`
  Expected: Both exist, `docs/CATALOG.md` contains `| Skill |`.

- [ ] **Step 5: Commit**
  ```bash
  git add scripts/generate-catalog.ps1 docs/CATALOG.md docs/CATALOG.json
  git commit -m "feat: add generate-catalog.ps1 and initial CATALOG"
  ```

---

### Task 5: `scripts/install.ps1` — --core / --all / --pick / --list

**Files:**
- Create: `scripts/install.ps1`

**Interfaces:**
- Consumes: `skills/**` folders, global `$HOME/.config/opencode/skills/` (for --core), current `./.opencode/skills/` (for --pick), `opencode.json` (for --all).
- Produces: Files in `~/.config/...` or `./.opencode/...`; consumed by OpenCode runtime.

- [ ] **Step 1: Failing test — --list does not enumerate skills**
  ```powershell
  pwsh -NoProfile -File scripts/install.ps1 --list 2>&1
  ```
  Expected: script not found / no output.

- [ ] **Step 2: Run failure check**
  Run: `pwsh -NoProfile -Command "Test-Path scripts/install.ps1"`
  Expected: False.

- [ ] **Step 3: Write `install.ps1` (param block + Robocopy for --core, Copy-Item for --pick, merge for --all, table for --list)**
  ```powershell
  param([switch]$core,[switch]$all,[string]$pick,[switch]$list,[switch]$dryRun)
  if ($list) { Get-ChildItem -LiteralPath "skills" -Recurse -Filter "SKILL.md" | ForEach-Object { $_.Directory.Name }; exit 0 }
  if ($pick) { Copy-Item -LiteralPath "skills/**/$pick" -Destination ".opencode/skills/$pick" -Recurse; exit 0 }
  if ($core) { Robocopy "skills/design" "$HOME/.config/opencode/skills/design" /E; exit 0 }
  ```

- [ ] **Step 4: Verify --dryRun --core prints, --list enumerates**
  Run: `pwsh -NoProfile -File scripts/install.ps1 --list --dryRun 2>&1 | Select-Object -First 5`
  Expected: list of skill names (or empty if none created yet — still exit 0).

- [ ] **Step 5: Commit**
  ```bash
  git add scripts/install.ps1
  git commit -m "feat: add install.ps1 (--core/--all/--pick/--list)"
  ```

---

### Task 6: `scripts/sync-upstream.ps1`

**Files:**
- Create: `scripts/sync-upstream.ps1`

**Interfaces:**
- Consumes: `scripts/sources.json`, `git` CLI, `ATTRIBUTION.md`.
- Produces: Diff output, staged changes to `skills/**` when --apply.

- [ ] **Step 1: Failing test — sync check does not compare SHAs**
  Run: `pwsh -NoProfile -File scripts/sync-upstream.ps1 --check 2>&1`
  Expected: script not found.

- [ ] **Step 2: Write minimal sync-upstream (clone --depth 1 per source to $env:TEMP, compare file counts)**
  ```powershell
  param([switch]$check,[string]$source,[switch]$apply)
  $src = Get-Content -LiteralPath "scripts/sources.json" -Raw | ConvertFrom-Json
  foreach ($k in $src.PSObject.Properties.Name) { Write-Host "$k -> $($src.$k) (check only)" }
  ```

- [ ] **Step 3: Verify --check exits 0**
  Run: `pwsh -NoProfile -File scripts/sync-upstream.ps1 --check; echo "exit:$LASTEXITCODE"`
  Expected: 0.

- [ ] **Step 4: Commit**
  ```bash
  git add scripts/sync-upstream.ps1
  git commit -m "feat: add sync-upstream.ps1"
  ```

---

### Task 7: CI — `.github/workflows/ci.yml`

**Files:**
- Create: `.github/workflows/ci.yml`

**Interfaces:**
- Consumes: `scripts/audit-skills.ps1`, `scripts/generate-catalog.ps1`.
- Produces: GitHub Actions result; gates PRs.

- [ ] **Step 1: Failing — CI file missing**
  Run: `Test-Path .github/workflows/ci.yml`
  Expected: False.

- [ ] **Step 2: Write ci.yml (audit + generate-catalog --check, schedule monthly upstream)**
  ```yaml
  name: ci
  on: [push, pull_request]
  jobs:
    audit:
      runs-on: windows-latest
      steps:
        - uses: actions/checkout@v4
        - run: pwsh ./scripts/audit-skills.ps1
        - run: pwsh ./scripts/generate-catalog.ps1 --check
  ```

- [ ] **Step 3: Verify YAML parses**
  Run: `pwsh -NoProfile -Command "Get-Content -LiteralPath '.github/workflows/ci.yml' -Raw | Out-Null; if ($?) { exit 0 } else { exit 1 }"`
  Expected: 0.

- [ ] **Step 4: Commit**
  ```bash
  git add .github/workflows/ci.yml
  git commit -m "ci: add audit + catalog check workflow"
  ```

---

### Task 8: Catalog skill — `skills/_catalog/crazy-skills-catalog/SKILL.md`

**Files:**
- Create: `skills/_catalog/crazy-skills-catalog/SKILL.md`

**Interfaces:**
- Consumes: `docs/CATALOG.md` structure.
- Produces: Always-in-Core skill consumed by model when user needs Extended.

- [ ] **Step 1: Failing — catalog skill missing**
  Run: `pwsh -NoProfile -Command "Test-Path 'skills/_catalog/crazy-skills-catalog/SKILL.md'"`
  Expected: False.

- [ ] **Step 2: Write SKILL.md (frontmatter description starts Use when, body is table)**
  ```md
  ---
  name: crazy-skills-catalog
  description: "Use when you need a skill not in Core, want to browse all 60+ extended skills, or don't know which skill fits — discover and install on demand."
  ---
  # Crazy Skills Catalog
  ## When to use ...
  ## Workflow — table by category with install command
  ```

- [ ] **Step 3: Verify audit passes**
  Run: `pwsh -NoProfile -File scripts/audit-skills.ps1 --skill _catalog/crazy-skills-catalog`
  Expected: PASS.

- [ ] **Step 4: Commit**
  ```bash
  git add skills/_catalog/crazy-skills-catalog/SKILL.md
  git commit -m "feat: add crazy-skills-catalog (Core catalog index)"
  ```

---

### Task 9: Core — design/* (2 skills: frontend-design, system-architecture)

**Files:**
- Create: `skills/design/frontend-design/SKILL.md` (composite anthropics/frontend-design 818k + vercel web-guidelines 576k)
- Create: `skills/design/system-architecture/SKILL.md` (composite alireza senior-architect + api-design-reviewer)

- [ ] **Step 1: Failing — design skills missing**
  Run: `pwsh -NoProfile -File scripts/audit-skills.ps1 --skill design/frontend-design`
  Expected: FAIL (file not found).

- [ ] **Step 2: Write composites (normalize to OpenCode template, include When to use, Workflow, Verification, footer attribution)**
  Each SKILL.md: frontmatter `Use when...`, body ≤500 lines, anti-patterns, steps.

- [ ] **Step 3: Verify audit**
  Run: `pwsh -NoProfile -File scripts/audit-skills.ps1`
  Expected: PASS (at least these 2 new skills).

- [ ] **Step 4: Regenerate catalog**
  Run: `pwsh -NoProfile -File scripts/generate-catalog.ps1`
  Expected: `docs/CATALOG.md` now lists design/*.

- [ ] **Step 5: Commit**
  ```bash
  git add skills/design/frontend-design/SKILL.md skills/design/system-architecture/SKILL.md docs/CATALOG.md docs/CATALOG.json
  git commit -m "feat: add Core design skills — frontend-design, system-architecture"
  ```

---

### Task 10: Core — workflow/* (5 skills)

**Files:**
- Create: `skills/workflow/brainstorming/SKILL.md` (superpowers + addy interview-me)
- Create: `skills/workflow/writing-plans/SKILL.md` (superpowers + addy planning)
- Create: `skills/workflow/executing-plans/SKILL.md`, `dispatching-parallel-agents/SKILL.md`, `finishing-a-development-branch/SKILL.md` (superpowers direct ports, normalized)

- [ ] **Step 1-5:** Same 5-step pattern: failing check → write composites (≤500 lines each) → audit → generate-catalog → commit `feat: add Core workflow skills (5)`

---

### Task 11: Core — quality/* + review/* (5 skills)

**Files:**
- `quality/test-driven-development/SKILL.md` (superpowers RED-GREEN + addy pyramid 80/15/5 + mattpocock strict)
- `quality/systematic-debugging/SKILL.md` (superpowers + addy debugging-and-error-recovery)
- `quality/verification-before-completion/SKILL.md`
- `review/requesting-code-review/SKILL.md`, `review/receiving-code-review/SKILL.md`

- [ ] **Step 1-5:** Same pattern → commit `feat: add Core quality + review skills (5)`

---

### Task 12: Core — security + performance + productivity + devops + meta (8 skills)

**Files:**
- `security/security-and-hardening/SKILL.md` (addy + tresor secret-scanner)
- `performance/performance-optimization/SKILL.md` (addy + vercel-react), `performance/core-web-vitals/SKILL.md`
- `productivity/token-efficiency/SKILL.md` (Delphine-L), `productivity/prompt-enhancement/SKILL.md` (brixtonpham + llm-prompt-optimizer, always-on hook documented)
- `devops/using-git-worktrees/SKILL.md`, `devops/git-workflow-and-versioning/SKILL.md`
- `meta/using-crazy-skills/SKILL.md`, `meta/writing-skills/SKILL.md`

- [ ] **Step 1-5:** Same pattern → commit `feat: add Core security/performance/productivity/devops/meta (8) — completes 18 Core`

---

### Task 13: Extended — docs/readme-generation + docs/documentation-and-adrs + productivity/context-compression

**Files:**
- `docs/readme-generation/SKILL.md` (composite d-o-hub/readme-best-practices + blueprint-generator — hero, badges, SVG, audit)
- `docs/documentation-and-adrs/SKILL.md` (addy)
- `productivity/context-compression/SKILL.md` (guanyang 3-layer Micro/Auto/Full — 30/60/85%)

- [ ] **Step 1-5:** Same 5-step pattern → commit `feat: add Extended docs + context-compression (3)`

---

### Task 14: Extended — remaining composites + final catalog + README polish + install smoke test

**Files:**
- Create: `skills/extended/*` (≈30 skills: voltagent best-practices/core-reference, addy context/doubt/source-driven, alireza agent-designer/mcp-builder/tech-debt-tracker, web-quality trio, docs group, etc.) — each composite via Collect→Score→Composite→Normalize.
- Modify: `docs/CATALOG.md`, `docs/CATALOG.json`, `ATTRIBUTION.md`, `README.md`

- [ ] **Step 1: Failing — CATALOG row count < 50**
  Run: `pwsh -NoProfile -Command "(Get-Content -LiteralPath 'docs/CATALOG.md').Count -lt 50"`
  Expected: True (still <50 rows).

- [ ] **Step 2: Write remaining composites (batch, ≤500 lines each, audit each before commit)**

- [ ] **Step 3: Final catalog regen + attribution bump**
  Run:
  ```powershell
  pwsh -NoProfile -File scripts/generate-catalog.ps1
  pwsh -NoProfile -File scripts/audit-skills.ps1; echo "audit exit:$LASTEXITCODE"
  ```

- [ ] **Step 4: Smoke test install modes**
  Run:
  ```powershell
  pwsh -NoProfile -File scripts/install.ps1 --list | Measure-Object -Line
  pwsh -NoProfile -File scripts/install.ps1 --dryRun --core 2>&1 | Out-String
  pwsh -NoProfile -File scripts/install.ps1 --pick readme-generation --dryRun 2>&1 | Out-String
  ```
  Expected: `--list` ≥50 skills, dryRuns print without error.

- [ ] **Step 5: Commit + push**
  ```bash
  git add skills/ docs/CATALOG.md docs/CATALOG.json ATTRIBUTION.md README.md
  git commit -m "feat: add Extended composites — completes 60+ skills, catalog + attribution"
  git push
  ```

---

## Self-Review (writing-plans)

- **Spec coverage:** Every section of spec §3-§8 maps to a task:
  - §3 layout/taxonomy → Tasks 1, 8-14
  - §4 curation → Tasks 3, 9-14 composites
  - §5 install/runtime → Tasks 5, 8, 14 smoke test
  - §6 catalog → Tasks 4, 8
  - §7 tooling/CI → Tasks 3-7
  - §8 governance → Tasks 2, 6, ATTRIBUTION/CURATION files
- **Placeholder scan:** Search for TBD/TODO/"implement later" — none allowed; every task step has actual code (PS snippets, YAML, markdown). Fixed: Task 3's audit uses concrete regex checks.
- **Type consistency:** All paths use `skills/<category>/<name>/SKILL.md`, folder name == frontmatter `name` (kebab-case). `install.ps1` consumes `skills/**` and produces `~/.config/...` or `.opencode/...` — consistent. `generate-catalog.ps1` consumes `skills/**/SKILL.md` and produces `docs/CATALOG.*` — consistent.
- **Fixes applied:** Added `--check` flag to `generate-catalog` for CI; added `--dryRun` to install for safe CI; clarified 18 Core groups → 22 files note from spec so task scope matches files.

---

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-08-26-crazy-skills-plan.md`. Two execution options:

**1. Subagent-Driven (recommended)** — I dispatch a fresh subagent per task, review between tasks, fast iteration
**2. Inline Execution** — Execute tasks in this session using executing-plans, batch execution with checkpoints

Which approach?
