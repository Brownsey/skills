---
name: personal-skill-library
description: Create, refine, install, or sync skills in Stephen's personal Git-backed Codex skill library. Use for work on this library or requests to maintain personal skills across devices, not ordinary application development or third-party plugin management.
---

# Personal skill library

Maintain the library at https://github.com/Brownsey/skills using its local clone.

## Find the source

If the current repository contains `skills/`, `global/AGENTS.md`, and `setup/install.ps1`, inspect its Git remote to confirm it is the intended library. Otherwise, inspect the target of the installed `personal-skill-library` folder in the user's personal skills directory; its source is under `<clone>/skills/personal-skill-library`. Ask for the clone location only when it cannot be determined. Never assume a username, drive, or checkout location.

Read the clone's AGENTS.md before editing. Make changes in the clone so Git records them. Use built-in skill-creator guidance when available for authoring; the conventions below are specific to this library.

## Author and install

- Store each reusable workflow in `skills/<name>/SKILL.md`. Give it a narrow description, a procedure suited to the user's actual workflow, and only the supporting files it needs.
- Keep shared personal expectations in `global/AGENTS.md`; keep application-specific commands with their application.
- On Windows, run `setup/install.ps1` from the clone to register new skills. Add `-IncludeGlobalInstructions` when applying changes to shared personal instructions.
- The installer creates folder junctions, so edits to an existing skill are available through its installed path. Run it again after adding a skill. If Codex does not show changes, restart it and test in a fresh task.
- Validate frontmatter and referenced resources, then try representative requests where practical. Distinguish structural validation from observing correct skill selection and behavior.

## Sync when requested

Inspect Git status, the branch, and the remote before syncing. With a clean working tree and an upstream configured, use `git pull --ff-only`. If local edits or divergent commits prevent a straightforward update, preserve them and explain the specific issue rather than resetting or force-pushing.

Review and commit only intended library changes when publishing is part of the user's request, then push to the verified remote. After pulling on another device, rerun the installer for newly added skills and changed shared instructions. Report whether changes are local, committed, or pushed; do not describe a local edit as synced.
