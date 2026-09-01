# Third-party skills

`skills/<name>/` contains unchanged copies of upstream skill directories at the exact commits recorded in `sources.json`. This repository's installer links them alongside our original skills. The full upstream projects, plugins and runtimes are not installed.

Keep personal choices, including Caveman ultra and Ponytail ultra, in `../global/AGENTS.md`. Do not edit vendored files to set defaults. Keep custom workflows in the repository's top-level `skills/` directory. Bundled Codex skills remain managed by Codex.

Each source record includes the upstream repository, directory, full commit SHA, local path, licence and local changes (normally an empty list). Root licence files are retained separately under `licenses/` so each skill directory remains an exact copy. Preserve notices inside the copied directories too.

Read imported instructions and inspect executable helpers before installing or running them. For updates, select a new exact revision, review its diff, replace the complete skill directory, verify it against upstream and update its source record. Updates are explicit; there is no automatic tracking of upstream branches.

Upstream Ponytail includes `argument-hint` in its frontmatter. The built-in skill-creator validator rejects this extra field; it is retained to preserve the original. Validate its YAML, name, description and references separately rather than silently modifying upstream metadata.

`web-design-guidelines` fetches a live upstream guideline document when used. Its copied skill is pinned; that remote document can change independently.

The pinned Playwright skill has several secondary-guide links missing sibling-folder prefixes. Their target files exist; use the main `SKILL.md` reference map to locate them. The source record documents this upstream limitation, and the copies remain unchanged.
