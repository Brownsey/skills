# Personal Codex setup

Stephen's skills, MCP definitions, and CLI tool list, shared between desktop and laptop through [Brownsey/skills](https://github.com/Brownsey/skills).

## Contents

- `skills/`: reusable personal skills; each folder contains a `SKILL.md`.
- `global/AGENTS.md`: shared personal expectations, installed as a managed block in your personal Codex instructions.
- `AGENTS.md`: instructions for maintaining this repository.
- `setup/install.ps1`: a repeatable Windows installer.
- `cli/tools.json`: command-line tools and installation guidance; `setup/check-tools.ps1` checks availability.
- `mcp/servers.toml`: portable MCP definitions, initially empty until servers are selected. See `mcp/README.md` for installation.
- `third-party/sources.json`: source revisions, licences, and local changes for imported skills. See `third-party/README.md`.

`personal-skill-library` teaches Codex this library's layout and installation/sync workflow. Pinned copies of `caveman` and `ponytail` provide the default ultra modes: shortest clear chat replies and minimal implementations. Their source revisions, licences, and small local changes are recorded in `third-party/sources.json`.

Install with `-IncludeGlobalInstructions` to activate the defaults across tasks. Ask for `caveman lite`, `ponytail lite`, or `normal mode` when you want to override them for a task. Add further development skills as your actual workflows become clear.

## Set up another Windows machine

Install Git and Codex, and make sure Git can access your GitHub account. Clone this repository into a convenient local folder, then open PowerShell in that clone:

```powershell
git clone https://github.com/Brownsey/skills.git
cd skills
.\setup\install.ps1 -IncludeGlobalInstructions
.\setup\check-tools.ps1
```

The installer supports Windows PowerShell 5.1 and PowerShell 7. It creates a junction for each skill under `$env:USERPROFILE\.agents\skills`, pointing into this clone. Junctions normally do not require administrator rights or Windows Developer Mode. Keep the clone in place after installing it.

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

Existing skill edits are visible through the junction immediately. Newly added skills need another installer run. Changes to shared global instructions also need another run. Renaming, removing, or relocating an installed skill requires inspecting its old junction and removing only that link; the installer intentionally does not delete existing links or replace conflicting folders.

## Add a skill

Open this repository in Codex and ask, for example:

> Use skill-creator to create a skill in this repository for my recurring workflow: [describe the actual task, conventions, and expected result].

Store it as `skills/<name>/SKILL.md`. Describe when it applies in its frontmatter and put its procedure in the body. Use relative paths for supporting files. Try both requests that should trigger it and requests that should not, then install and commit it.

Keep application-specific conventions in the application's own repository. Keep credentials, local Codex settings, caches, and session history out of this repository.

## MCP servers, CLIs, and third-party skills

The repository stores reproducible definitions and instructions. Each device installs its own programs and authenticates separately. `setup/install.ps1` installs skills and optional shared instructions only; it does not apply MCP configuration or install CLI programs.

Use `setup/check-tools.ps1` to see which listed commands are available and how to install missing ones. GitHub CLI is optional; normal Git push/pull already works with Git Credential Manager.

For MCP servers, maintain selected definitions in `mcp/servers.toml`, then apply the relevant server entries to the device's Codex config using `mcp/README.md`. No servers are enabled by this starter setup.

When customising a third-party skill, place its reviewed copy under `skills/`, preserve its licence, and record the exact upstream commit in `third-party/sources.json`. For unchanged external installations, keep a pinned source record and installation instructions instead. There is no automatic upstream updater.

## References

- [Official skill discovery and authoring guidance](https://learn.chatgpt.com/docs/build-skills)
- [Official AGENTS.md guidance](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
