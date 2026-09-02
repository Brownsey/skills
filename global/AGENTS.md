## Personal skill use

- Before substantive work, check the available skill descriptions and read the skills that clearly apply.
- Briefly name each skill used and explain why it applies.
- Follow the applicable workflow and verify its relevant outputs before reporting completion.
- If a required skill is unavailable, explain the limitation and continue with useful work where possible.
- Keep application-specific conventions and commands in that application's repository.

## Skill routing

- Use `fullstack-delivery` for an application brief, execution-plan refinement, or end-to-end implementation. Default to its `light` profile. If requirements exceed the selected profile, explain the concrete implication and retain that profile unless the user changes it.
- Use `frontend-design` before new UI or a substantial visual redesign, then use `vercel-react-best-practices` while implementing or reviewing React or Next.js code. Use `web-design-guidelines` for a requested UI, UX or accessibility audit.
- Use `test-driven-development` for feature work and behaviour-changing fixes. Use `playwright-best-practices` when Playwright is selected or already present. Use `requesting-code-review` and `verification-before-completion` for their final review and evidence gates.
- Use `hexagonal-architecture` only to assess code with substantial business rules, multiple external adapters or difficult infrastructure coupling. Apply it only when that assessment supports it.
- Use `vercel-cli` for Vercel deployment, environment, logs or project operations. Use the hosted Supabase workflow in `fullstack-delivery` when the persistence defaults below select Supabase.
- Use `python-quality` for Python lint, format, type-check, test, commit-hook or CI setup when the repository lacks a coherent existing gate.
- Use `personal-skill-library` only when creating, refining, installing or syncing this personal skill library.
- Prefer the smallest clearly applicable set of skills. Do not load overlapping skills merely because they are available.

## Default modes

- These are personal mode selections applied after reading the skills; they override the upstream default mode without modifying upstream files.
- Read the `caveman` skill and use its `ultra` mode for chat replies by default: the shortest wording that preserves meaning and technical accuracy.
- For coding tasks, read the `ponytail` skill and use its `ultra` mode by default: reuse existing code and platform capabilities, minimise implementation and dependencies, and avoid speculative features.
- Keep the requested outcome, correctness, and necessary verification intact when simplifying. Keep any required progress updates brief.
- An explicit request for another mode, more explanation, or normal prose overrides these defaults. If the user disables a mode, keep it disabled for the rest of the task unless they re-enable it; do not reactivate it on the next reply.

## Required development checks

- Use `frontend-design` before building new UI or substantially reshaping its visual direction. Keep the design plan compact and share the chosen typography, palette, layout and signature interaction with frontend workers. Follow the brief and existing design system; small fixes should preserve the established direction.
- For product screens, prioritise the main user task, clear hierarchy and useful interaction states. Make distinctive details serve that task. Ponytail minimises implementation complexity while preserving the agreed UX quality, accessibility and visual consistency.

- For feature work and behavior-changing fixes, define observable acceptance criteria before implementation: success, relevant failure/permission cases, persistence and user-visible states. Record which test or check proves each criterion and use the `test-driven-development` skill. For existing code, add the regression test before fixing the defect; do not discard unrelated working code to retroactively impose TDD.
- Use `hexagonal-architecture` to assess suitability when substantial business rules or difficult-to-test integrations suggest it; apply the pattern only when justified. Keep routine CRUD and UI work direct. Use `playwright-best-practices` for Playwright tests. For unit/component tests, use the existing runner and version-matched documentation (for example, Vitest/Testing Library or pytest). Do not install a different test framework merely because a skill is available.
- When an app needs durable shared persistence and the brief does not specify a provider, default to hosted Supabase. During an authorised implementation or deployment, create and link the hosted project automatically when the intended app has no existing database; this routine provisioning is part of delivering the app. Reuse an existing intended provider or linked Supabase project rather than replacing it. Planning-only requests do not create cloud resources.
- For hosted Supabase, follow `fullstack-delivery/references/supabase-hosted.md` when available: prefer the authenticated organisation when unambiguous, default new UK projects to `eu-west-2`, commit migrations, dry-run then apply them with `db push`, generate application types, and configure the linked Vercel project with its URL and publishable key. Never expose elevated keys, database passwords or access tokens in Git, chat or command output. Do not start a local Supabase stack, require Docker, reveal secret keys, reset a linked database or delete a project unless Stephen explicitly requests that action.
- Ponytail minimises implementation overhead; it must not remove required tests, appropriate fixtures, test tooling, or independent checks. Documentation-only edits and trivial nonbehavioral changes need relevant validation, not invented application tests.

## Python quality defaults

- Preserve a repository's established Python tooling. For a new Python service with no stated standard, use `uv`, commit `uv.lock`, use Ruff for linting and formatting, and use pytest for tests. Add a project-pinned type checker such as `ty` when typed boundaries or non-trivial backend logic make it useful.
- Provide one repository command named `verify` (or the nearest existing convention) that runs Ruff lint, Ruff format check, configured type checks, pytest and any required integration checks. Keep configuration in `pyproject.toml` where the tools support it.
- In CI and final validation, use the lockfile without silently updating it, for example `uv run --locked ...`. CI must run the aggregate verification command on the deliverable revision.
- Keep commit hooks fast. Default Python pre-commit hooks to Ruff lint/fix and formatting using the project's locked Ruff version. Keep unit, integration, browser and production-build gates in `verify`, CI and dedicated validation agents unless the repository's suite is demonstrably fast enough for an existing hook convention.
- Set coverage targets only when they represent meaningful required behaviour. Coverage percentage supplements acceptance-focused tests; it does not replace them.

## Git and issue conventions

- When creating a branch for Stephen's work, name it `brownsey_<short-kebab-case-name>`, for example `brownsey_add-account-filter`. Derive the name from the intended outcome, use lowercase ASCII letters, numbers and hyphens after the prefix, and keep it concise. Preserve an existing user branch unless the user asks to rename it.
- Use Conventional Commits: `<type>(<optional-scope>): <imperative description>`. Use `feat` for user-visible capability, `fix` for defects, `refactor` for behaviour-preserving restructuring, `test`, `docs`, `build`, `ci`, `chore`, `perf`, `style` or `revert` when those accurately describe the change.
- Keep each commit cohesive. Use lowercase types and scopes, omit a final period from the subject, and add a body when the reason or trade-off is not evident from the diff. Mark breaking changes with `!` after the type/scope and explain them in a `BREAKING CHANGE:` footer.
- Before committing, inspect the staged diff, exclude unrelated files and secrets, and run the relevant checks. Do not use vague messages such as `updates`, `fix stuff` or `wip` for completed work.
- When creating a GitHub issue, search open and closed issues for a duplicate first. Use the same conventional prefix in the title, for example `feat(auth): support passkeys` or `fix(api): reject expired tokens`.
- Issue bodies state the problem and user impact, observable acceptance criteria, relevant constraints or dependencies, and the check that will prove completion. Bug issues also include reproduction steps, expected versus actual behaviour and the relevant environment. Keep implementation ideas separate from requirements and omit sections that add no information.
- Reuse the repository's existing labels and issue forms when present. Link completed work with GitHub closing syntax such as `Closes #123` in the pull-request description or commit body when automatic closure is intended.

## Dedicated validation agents

- Required checks run in dedicated subagents, separate from the agents that implemented the behavior. For frontend/backend changes, give each affected side its own validation agent. A single affected side needs only its corresponding validator. Use available slots sequentially if necessary; implementation workers' local tests are useful feedback but do not replace this gate.
- Give validators the original acceptance criteria, API contract, relevant files, actual change scope (including uncommitted changes), repository commands and isolated test environment. Provide concise context rather than the lead's conversation history. Assign disjoint test files and coordinate shared installs, builds, servers and databases centrally.
- Frontend validation covers applicable component interactions, loading/empty/error states, accessibility and the browser journey. For substantive UI changes, inspect the running app and desktop/mobile screenshots against the agreed design: hierarchy, spacing, readable content, responsive layout and clear actions. Use `web-design-guidelines` for UI guideline reviews; report unavailable visual checks rather than inferring visual quality from passing tests. Backend validation covers domain rules, input validation, authorization, persistence and real adapter/API integration. Reuse the existing test stack. At least one integrated journey must use the real backend when both sides form the deliverable.
- Validators execute checks and may add missing tests in their assigned files. They do not change production code or acceptance criteria. Classify failures against the requirement: production defects return to the implementation owner; a faulty test may be corrected with an explicit reason. Never skip required cases, weaken assertions, refresh snapshots or lower thresholds merely to obtain a pass.
- After implementation and test changes settle, use `requesting-code-review` to dispatch a separate read-only reviewer for requirement coverage, test quality and code defects. Give the actual base and final change scope; do not assume `HEAD~1` includes the work. A reviewer is not asked to approve their own implementation or tests.
- Validators and reviewers are leaf agents: do not recursively dispatch more agents. Their return includes checks/commands, exit status, failures or skips, requirement coverage, findings and the revision or working-tree state tested. Do not treat a bare success claim as evidence.
- Use `verification-before-completion` before reporting completion. Evidence must cover the final relevant state; rerun checks invalidated by fixes. Evidence from a dedicated validator for unchanged code can be reused without running the same command again in every message. Repeat tests for a concrete flakiness/concurrency risk rather than imposing an arbitrary repetition count. Skipped, quarantined, filtered-out or flaky required cases do not satisfy acceptance. Resolve substantive findings before declaring the work ready.
- If subagents or a required test environment are unavailable, report the missing gate and perform useful available checks; do not claim independent validation passed. These instructions govern workflow, while enforceable merge/deploy checks must be configured in the application repository's CI. They do not require a manual PR or authorize merging/deployment by themselves.
