# Personal Codex setup

Stephen's skills, MCP definitions, and CLI tool list, shared between desktop and laptop through [Brownsey/skills](https://github.com/Brownsey/skills).

## Contents

- `skills/`: original personal skills; each folder contains a `SKILL.md`.
- `third-party/skills/`: unchanged upstream skill directories, pinned to recorded commits.
- `global/AGENTS.md`: shared personal expectations, installed as a managed block in your personal Codex instructions.
- `AGENTS.md`: instructions for maintaining this repository.
- `setup/install.ps1`: a repeatable Windows installer.
- `cli/tools.json`: command-line tools and installation guidance; `setup/check-tools.ps1` checks availability.
- `mcp/servers.toml`: portable Vercel MCP configuration. See `mcp/README.md` for installation.
- `third-party/sources.json`: source revisions, licences, and local changes for imported skills. See `third-party/README.md`.

`personal-skill-library` teaches Codex this library's layout and installation/sync workflow. Pinned copies of `caveman` and `ponytail` provide the default ultra modes: shortest clear chat replies and minimal implementations. The upstream files are unchanged under `third-party/skills/`; ultra preferences live in `global/AGENTS.md`. Sources and licences are recorded in `third-party/sources.json`.

Install with `-IncludeGlobalInstructions` to activate the defaults across tasks. Ask for `caveman lite`, `ponytail lite`, or `normal mode` when you want to override them for a task. Add further development skills as your actual workflows become clear.

`fullstack-delivery` provides concise planning, a shared API contract, parallel frontend/backend ownership, early Vercel deployment and final verification. Choose a [light, medium or high profile](skills/fullstack-delivery/references/profiles.md) in its [launch prompt](skills/fullstack-delivery/references/launch-prompt.md). Profiles control implementation depth; all preserve required behaviour. Installing the workflow does not create an app or authenticate with Vercel.

`python-quality` establishes or repairs Python gates with `uv`, Ruff, pytest, optional project-pinned type checking, fast commit hooks and one CI-backed verification command. Its [workflow](skills/python-quality/references/workflow.md) is informed by [Brownsey/lendable](https://github.com/Brownsey/lendable) and current Astral documentation.

The imported Vercel skills cover React best practices, UI guideline reviews and Vercel CLI operations. They remain direct upstream copies; use only the guidance relevant to the current task.

Anthropic's `frontend-design` guides new UI and substantial redesigns with a compact visual direction, intentional typography and useful interaction states. Shared instructions preserve existing design systems and require the frontend validation agent to inspect the running app and desktop/mobile screenshots for substantive UI changes. Minimal implementation must preserve the agreed UX quality. The upstream skill and its Apache-2.0 licence remain unchanged.

`hexagonal-architecture` ports the useful boundary and dependency-injection guidance from the personal Claude skill to Python and TypeScript/Next.js. It keeps business rules testable without imposing placeholder layers. The shared global instructions require dedicated validation agents separate from implementation authors, plus a read-only reviewer, using the testing skills below. Read the [testing workflow and definition-of-done example](skills/fullstack-delivery/references/testing-workflow.md) for frontend/backend test selection and application CI guidance.

## Original skill sources

These links open the original GitHub skill directories at the exact versions included here. Copies live under `third-party/skills/`; source revisions and licence notices are recorded in [third-party/sources.json](third-party/sources.json).

| Skill | Original GitHub source |
| --- | --- |
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

`fullstack-delivery`, `hexagonal-architecture`, `python-quality` and `personal-skill-library` are original skills maintained in this repository. No full Superpowers plugin or automatic test-healing loop is installed. Upstream testing skills remain unchanged; the global instructions preserve acceptance criteria, require independent execution and prevent unnecessary repeat runs.

## Set up another Windows machine

Install Git and Codex, and make sure Git can access your GitHub account. Clone this repository into a convenient local folder, then open PowerShell in that clone:

```powershell
git clone https://github.com/Brownsey/skills.git
cd skills
.\setup\install.ps1 -IncludeGlobalInstructions
.\setup\check-tools.ps1
```

The installer supports Windows PowerShell 5.1 and PowerShell 7. It reads both `skills/` and `third-party/skills/` and creates a junction for each skill under `$env:USERPROFILE\.agents\skills`, pointing into this clone. Junctions normally do not require administrator rights or Windows Developer Mode. Keep the clone in place after installing it.

The optional `-IncludeGlobalInstructions` switch adds or updates the marked Brownsey/skills block in `$env:CODEX_HOME\AGENTS.md`, or `$env:USERPROFILE\.codex\AGENTS.md` when CODEX_HOME is unset. Existing content outside that block is preserved, and the file is backed up before any change. Edit shared preferences in `global/AGENTS.md`, then rerun the installer on each device.

If local policy blocks script execution, follow that device's PowerShell policy rather than changing it automatically. You can still inspect the script and ask Codex to help install it.

Restart Codex if new skills are not visible. In a fresh task, ask it to use `personal-skill-library` and report the source it read. That confirms discovery; the installer's success alone does not prove a running Codex session has refreshed its catalogue.

## Work across devices

Before editing, open PowerShell in the clone:

```powershell
git status
git pull --ff-only
.\setup\install.ps1 -IncludeGlobalInstructions
```

Start from a clean working tree. If pulling stops because the two devices have different commits, inspect and resolve the divergence before continuing; don't force-push or discard work.

After editing, inspect the changes and stage the specific files you want to share:

```powershell
git switch -c brownsey_refine-personal-skill-workflow
git diff
git add skills/personal-skill-library/SKILL.md
git diff --cached
git commit -m "docs(skills): refine personal skill workflow"
git push -u origin HEAD
```

The file and commit message above are examples; select the actual files you changed. On the other machine, pull and rerun the installer. GitHub sync is explicit, through push and pull. Offline edits stay local until pushed.

Existing skill edits are visible through the junction immediately. Newly added skills need another installer run. Changes to shared global instructions also need another run. The installer migrates this library's old `skills/<name>` junctions to `third-party/skills/<name>` when applicable. Other relocations or removals require inspecting and removing only the old link; unrelated folders and conflicting links are protected.

## Add a skill

Open this repository in Codex and ask, for example:

> Use skill-creator to create a skill in this repository for my recurring workflow: [describe the actual task, conventions, and expected result].

Store it as `skills/<name>/SKILL.md`. Describe when it applies in its frontmatter and put its procedure in the body. Use relative paths for supporting files. Try both requests that should trigger it and requests that should not, then install and commit it.

Keep application-specific conventions in the application's own repository. Keep credentials, local Codex settings, caches, and session history out of this repository.

## MCP servers, CLIs, and third-party skills

The repository stores reproducible definitions and instructions. Each device installs its own programs and authenticates separately. `setup/install.ps1` installs skills and optional shared instructions only; it does not apply MCP configuration or install CLI programs.

Use `setup/check-tools.ps1` to see which listed commands are available and how to install missing ones. Use GitHub CLI for repository, pull request and workflow operations; normal Git push/pull can continue using Git Credential Manager. Follow [CLI setup](cli/README.md) on each device.

Supabase uses a remote-only workflow by default: authenticate the project-pinned CLI, create and link a hosted project, commit migrations and apply them with `db push`. Docker and the local Supabase stack are excluded unless explicitly requested.

Tool sources: [GitHub CLI on GitHub](https://github.com/cli/cli), [Vercel CLI on GitHub](https://github.com/vercel/vercel), [Supabase CLI setup](https://supabase.com/docs/guides/local-development/cli/getting-started), and [official Vercel MCP setup](https://vercel.com/docs/agent-resources/vercel-mcp).

For MCP servers, maintain selected definitions in `mcp/servers.toml`, then apply the relevant server entries to the device's Codex config using `mcp/README.md`. Vercel is the selected server; each device needs its own configuration and OAuth consent.

Keep imported skills unchanged under `third-party/skills/`, original workflows under `skills/`, and personal preferences in `global/AGENTS.md`. Preserve upstream licence notices and exact source revisions. There is no automatic upstream updater.

## References

- [Official skill discovery and authoring guidance](https://learn.chatgpt.com/docs/build-skills)
- [Official AGENTS.md guidance](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
