# Personal Codex skill library

This repository is the shared source for Stephen's custom skills on desktop and laptop.

- Put original skills in `skills/<skill-name>/SKILL.md` and unchanged upstream skill directories in `third-party/skills/<skill-name>/`. Use the built-in skill-creator guidance when available.
- Keep descriptions specific. Add skills for actual workflows and demonstrated needs, not speculative capabilities.
- Keep project-specific instructions with their application repository.
- Use relative paths inside skills. Setup scripts must derive machine paths at runtime.
- `global/AGENTS.md` contains shared personal preferences. The root AGENTS.md governs maintenance of this repository only.
- `setup/install.ps1` links skills into the personal discovery directory. With `-IncludeGlobalInstructions`, it updates a marked block in the personal AGENTS.md while preserving other content.
- When changing the installer, verify installation, a repeated run, and protection of existing unrelated files using temporary destination directories.
- Before committing, review the diff and ensure it contains only intended library files. Keep credentials, logs, caches, and machine-specific configuration out of this repository.
- Keep MCP definitions in `mcp/servers.toml` and CLI installation guidance in `cli/tools.json`. Store environment variable names rather than secret values. Do not copy an entire local Codex config into Git.
- Keep upstream files unchanged. Record sources and exact revisions in `third-party/sources.json`, and preserve root licence notices in `third-party/licenses/`. Put personal mode preferences in `global/AGENTS.md`. Review imported instructions and scripts before installing or running them.
