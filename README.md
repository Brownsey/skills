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

The imported Vercel skills cover React best practices, UI guideline reviews and Vercel CLI operations. They remain direct upstream copies; use only the guidance relevant to the current task.

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
git diff
git add skills/personal-skill-library/SKILL.md
git diff --cached
git commit -m "Refine personal skill library workflow"
git push
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

For MCP servers, maintain selected definitions in `mcp/servers.toml`, then apply the relevant server entries to the device's Codex config using `mcp/README.md`. Vercel is the selected server; each device needs its own configuration and OAuth consent.

Keep imported skills unchanged under `third-party/skills/`, original workflows under `skills/`, and personal preferences in `global/AGENTS.md`. Preserve upstream licence notices and exact source revisions. There is no automatic upstream updater.

## References

- [Official skill discovery and authoring guidance](https://learn.chatgpt.com/docs/build-skills)
- [Official AGENTS.md guidance](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
