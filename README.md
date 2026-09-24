# Personal Codex setup

Skills, shared `AGENTS.md` instructions, CLI setup and MCP configuration synced through [Brownsey/skills](https://github.com/Brownsey/skills).

## Fresh Windows device

Give an agent this request:

> Set up `https://github.com/Brownsey/skills.git` using its README. Reuse a clean clone with the matching `origin`, or clone it into a permanent user-owned folder. Preserve local edits and conflicting skill directories. Install the skills and shared instructions, check the listed CLI tools, configure Vercel MCP, and ask me for browser consent when required. Verify the links, effective personal `AGENTS.md`, Git remote and repository status. Report the installed paths and anything that still needs my action.

Manual setup:

```powershell
git clone https://github.com/Brownsey/skills.git
cd skills
.\setup\install.ps1 -IncludeGlobalInstructions
.\setup\check-tools.ps1
```

The installer supports Windows PowerShell 5.1 and PowerShell 7. It links every skill from `skills/` and `third-party/skills/` into `$env:USERPROFILE\.agents\skills`. Use `-SkillsDirectory <verified-path>` only when the device uses a different Codex skill directory. Keep the clone in place because the installed links point into it.

`-IncludeGlobalInstructions` updates the marked Brownsey/skills block in `$env:CODEX_HOME\AGENTS.md`, or `$env:USERPROFILE\.codex\AGENTS.md` when `CODEX_HOME` is unset. Existing content is preserved and changed files are backed up. The installer stops instead of replacing conflicting links, duplicate skill names or malformed instruction markers.

Complete device-local setup as needed:

```powershell
gh auth status
codex mcp get vercel
codex mcp list
```

To allow up to 25 subagents in each task, add this to `$env:USERPROFILE\.codex\config.toml` on every device, then restart Codex:

```toml
[agents]
max_concurrent_threads_per_session = 25
```

Follow [CLI setup](cli/README.md) and [MCP setup](mcp/README.md) for missing tools or authentication. Credentials and OAuth consent are not stored in this repository. Restart Codex and test `personal-skill-library` in a fresh task after adding a skill or refreshing the catalogue.

## Sync devices

Before work:

```powershell
git status
git pull --ff-only
.\setup\install.ps1 -IncludeGlobalInstructions
```

Preserve local edits if the pull cannot fast-forward. Do not reset or force-push to resolve device divergence.

After work:

```powershell
git diff
git add <intended-files>
git diff --cached
git commit -m "<conventional-commit>"
git push
```

Existing skill edits are visible through their links immediately. Run the installer again for new or relocated skills and changed global instructions.

## Repository layout

| Path | Contents |
| --- | --- |
| `skills/` | Original personal skills |
| `third-party/skills/` | Unchanged upstream skills |
| `third-party/sources.json` | Upstream URLs, revisions and licences |
| `third-party/licenses/` | Upstream root licence notices |
| `global/AGENTS.md` | Shared personal instructions |
| `setup/install.ps1` | Skill and global-instruction installer |
| `setup/check-tools.ps1` | CLI availability check |
| `cli/` | CLI manifest, setup and utilities |
| `mcp/` | Portable MCP definitions and setup |

Original skills:

- [`fullstack-delivery`](skills/fullstack-delivery/SKILL.md) — profiles and [launch prompt](skills/fullstack-delivery/references/launch-prompt.md)
- [`fullstack-efficient`](skills/fullstack-efficient/SKILL.md) — token-first model, context and dispatch overlay: Astra 6 for architecture, Sol 6 for other substantive work, and Luna 6 for bounded mechanical work
- [`independent-validation`](skills/independent-validation/SKILL.md) — risk-based lead checks, combined independent passes, or separate validators plus final review
- [`tokenomics-audit`](skills/tokenomics-audit/SKILL.md) — explicit or scheduled audits of measured usage, structural waste, rework, and cost per accepted outcome
- [`hexagonal-architecture`](skills/hexagonal-architecture/SKILL.md)
- [`personal-skill-library`](skills/personal-skill-library/SKILL.md)
- [`python-quality`](skills/python-quality/SKILL.md)

Archify creates validated, interactive architecture, workflow, sequence, data-flow and lifecycle diagrams from repository evidence or system descriptions. Shared instructions route architecture requests through it while preserving `hexagonal-architecture` for applicable code-boundary decisions.

## Upstream skill sources

Exact revisions and licences are recorded in [third-party/sources.json](third-party/sources.json).

| Skill | Source |
| --- | --- |
| Archify | [tt-a1i/archify](https://github.com/tt-a1i/archify/tree/c826e6c3a7abad19c0f3cd1ca57207d54b1ad8de/archify) |
| Animate | [emilkowalski/skills](https://github.com/emilkowalski/skills/tree/d23d7f88a2e21c9e4b1418c7abe420f5c1052ba7/skills/animate) |
| Frontend Design | [anthropics/skills](https://github.com/anthropics/skills/tree/53048666b05b4799081517d00e09e0a2dd688678/skills/frontend-design) |
| Caveman | [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman/tree/df2ccd85c94ec3c8289cb62ac020d241ccfb0c60/skills/caveman) |
| Ponytail | [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail/tree/2ed6c52c9d7e5e56942508591085fd45dea277d3/skills/ponytail) |
| Vercel React Best Practices | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills/tree/063bee94c3f4df8453406c830b0a7df0f2860278/skills/react-best-practices) |
| Web Design Guidelines | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills/tree/063bee94c3f4df8453406c830b0a7df0f2860278/skills/web-design-guidelines) |
| Vercel CLI | [vercel/vercel](https://github.com/vercel/vercel/tree/e06cc643cec6a47bd9344af7f4589c736d95ed15/skills/vercel-cli) |
| Test-Driven Development | [obra/superpowers](https://github.com/obra/superpowers/tree/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/skills/test-driven-development) |
| Verification Before Completion | [obra/superpowers](https://github.com/obra/superpowers/tree/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/skills/verification-before-completion) |
| Requesting Code Review | [obra/superpowers](https://github.com/obra/superpowers/tree/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/skills/requesting-code-review) |
| Playwright Best Practices | [currents-dev/playwright-best-practices-skill](https://github.com/currents-dev/playwright-best-practices-skill/tree/283d5cbc5d11aac1abda058b16ad22c317d54dc0/playwright-best-practices) |

## Add or update a skill

Use `skill-creator` for original skills. Store them in `skills/<name>/SKILL.md`, use relative resource paths, validate them, then rerun the installer.

Keep imported skills unchanged in `third-party/skills/<name>/`. Record their exact source revision in `third-party/sources.json` and preserve the upstream root licence in `third-party/licenses/`.

Keep application-specific commands in the application repository. Do not commit credentials, caches, local Codex configuration or session history.

## CLI and MCP

`setup/install.ps1` does not install programs or apply MCP configuration. Use [cli/README.md](cli/README.md), [cli/tools.json](cli/tools.json), [mcp/README.md](mcp/README.md) and [mcp/servers.toml](mcp/servers.toml) on each device.

The Supabase workflow uses hosted projects and remote migrations. Docker and the local Supabase stack are excluded unless explicitly requested.
