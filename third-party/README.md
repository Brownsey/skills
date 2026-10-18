# Third-party skills

`skills/<name>/` contains unchanged copies of upstream skill directories at the exact commits recorded in `sources.json`. This repository's installer links them alongside our original skills. The full upstream projects, plugins and runtimes are not installed.

Keep personal choices, including Caveman ultra and Ponytail ultra, in `../global/AGENTS.md`. Do not edit vendored files to set defaults. Keep custom workflows in the repository's top-level `skills/` directory. Bundled Codex skills remain managed by Codex.

Each source record includes the upstream repository, directory, full commit SHA, local path, licence and local changes (normally an empty list). Root licence files are retained separately under `licenses/` so each skill directory remains an exact copy. Preserve notices inside the copied directories too.

Read imported instructions and inspect executable helpers before installing or running them. For updates, select a new exact revision, review its diff, replace the complete skill directory, verify it against upstream and update its source record. Updates are explicit; there is no automatic tracking of upstream branches.

Upstream Ponytail includes `argument-hint` in its frontmatter. The built-in skill-creator validator rejects this extra field; it is retained to preserve the original. Validate its YAML, name, description and references separately rather than silently modifying upstream metadata.

Upstream `ultracave` and `megacave` include `disable-model-invocation`; retain it unchanged and validate their YAML separately too. Caveman now delegates ultra and Classical Chinese modes to these companions. Shared personal instructions explicitly select `ultracave` for the existing ultra default; `megacave` remains on demand. Engine hooks and runtime components are not installed, and no hook state is implied.

`web-design-guidelines` fetches a live upstream guideline document when used. Its copied skill is pinned; that remote document can change independently.

The pinned Playwright skill has several secondary-guide links missing sibling-folder prefixes. Their target files exist; use the main `SKILL.md` reference map to locate them. The source record documents this upstream limitation, and the copies remain unchanged.

React Best Practices has three links in `AGENTS.md` missing the `rules/` prefix; their targets exist under that folder. The Caveman companions' READMEs link to `../../docs/HONEST-NUMBERS.md` in the full upstream repository, outside the copied skill folders. Their skill instructions are self-contained. These upstream reference limitations are recorded in `sources.json` without changing imported files.

Animate's preexisting component-building branch refers to `pick-ui-library`, which is not installed here. This does not affect its animation workflow. If that branch applies, report the unavailable skill and preserve the application's established component conventions.

## Update review: 18 October 2026

Reviewed all 12 previously vendored skills against the default-branch snapshots recorded as `last_reviewed.upstream_revision` in `sources.json`. Updated Archify, Animate, Frontend Design, Caveman, Ponytail, Test Driven Development, and Requesting Code Review. Vercel CLI already matched upstream after integrating the remote library updates. React Best Practices, Web Design Guidelines, Verification Before Completion, and Playwright Best Practices also had no new skill content. Keep their existing pins; a newer repository commit alone does not require a content update.

Imported the two Caveman mode companions required to preserve its existing mode choices. All copies remain byte-for-byte upstream content with exact revision pins and retained licences/notices. Personal Sol/Luna routing overrides upstream reviewer choices. Existing user authorization, targeted validation requirements, and default modes remain in shared instructions rather than patches to imported files.

Caveman's current upstream repository is Apache-2.0. Retain its root `LICENSE`, `NOTICE`, `LICENSE-MIT` for earlier contributions, and `LICENSING.md` history under `licenses/caveman-*`; all three related source records identify these files. The older manifest's MIT-only description no longer describes this revision.

The nine upstream repositories' root notices were checked. Anthropic's broader `THIRD_PARTY_NOTICES.md` is retained under `licenses/anthropic-skills-THIRD_PARTY_NOTICES.md` for source provenance; its listed tooling/runtime packages are not included with the two-file Frontend Design skill. Archify's bundled attribution notice is identical to its upstream root notice.

Archify is now 3.2.0, including ERD/class/tree/timeline/waterfall diagrams and requested explainer pages. Its package scripts refer to the full upstream repository's sibling scripts and tests, which are outside the copied skill subtree; do not treat `npm test` inside this vendored directory as a supported standalone gate. Native finalization uses Chrome and may perform a bounded update-notice check. Update awareness does not authorize installation, and explainer preferences must not be persisted without the user's request. Preserve its bundled Pele and font notices alongside its MIT licence.

Whitespace checks report three upstream blank lines in Archify's bundled `examples/lifecycle-agent-run.html` and 14 lines in the retained Anthropic root notice. Preserve these bytes for exact source fidelity rather than editing imported content. Authored library files pass the whitespace check separately.
