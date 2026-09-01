# Third-party skills

Use two approaches according to how a skill will be maintained:

- **Customised copy:** place a reviewed copy in `skills/<name>/`, keep its licence and required notices, and record its source in `sources.json`. The regular skill installer links this copy on both devices.
- **Unchanged external installation:** record its exact source revision and per-device installation instructions in `sources.json`. Use that source's supported installer on each machine. Our installer does not fetch external skills from this file.

Prefer a customised copy when it is part of a frequently used workflow or you want to adapt its instructions. Prefer an external installation when you want the upstream package to remain responsible for its structure. Keep bundled Codex skills managed by Codex.

For each source record, include:

- `name`: local skill name.
- `mode`: `copy` or `external`.
- `source_url`: upstream repository URL.
- `source_path`: skill directory within that repository.
- `revision`: exact full upstream commit SHA, not a moving branch.
- `license`: identified licence and location of retained licence/notice files.
- `local_path`: repository-relative path for a copied skill, or null for an external installation.
- `installation`: per-device steps for an external installation, or null for a copy.
- `local_changes`: concise notes about deliberate modifications.

Read imported instructions and inspect executable helpers before installing or running them. If reuse permission is unclear, check it before copying or redistributing the skill. Resolve name collisions so Codex can distinguish the intended skill.

To update a copied skill, compare its recorded revision with a selected newer upstream revision, review the differences, preserve deliberate local changes, test the result, and update the recorded SHA. Do not overwrite local customisations or automatically track upstream's latest branch.
