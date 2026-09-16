## Personal skill use

- Before substantive work, read the clearly applicable skills, name them briefly, follow their workflows, and verify relevant outputs. Keep application-specific commands in the application repository.
- Use the smallest non-overlapping skill set. If a required skill or environment is unavailable, state the missing gate and continue with useful in-scope work.

## Routing

- Use `fullstack-delivery` for app briefs, execution-plan refinement, and end-to-end delivery; default to its `light` profile and time-first scheduling. Use `fullstack-efficient` only when requested or when the brief asks for tiered models or token-efficient delivery; its token-first model/context/dispatch policy overrides only the base dispatch objective.
- Use `independent-validation` for the risk-based implementation evidence gate. Use `tokenomics-audit` only when explicitly requested or by an explicit periodic schedule, never as a routine delivery step.
- Use `archify` for architecture, system, workflow, sequence, data-flow, and lifecycle visuals. Use `hexagonal-architecture` only when substantial business rules or difficult infrastructure coupling make ports and adapters useful.
- Use `frontend-design` before new UI or a material visual redesign, `vercel-react-best-practices` while implementing React/Next.js, and `animate` only for purposeful motion with reduced-motion behaviour. Use `web-design-guidelines` for UI/UX/accessibility review.
- Use `test-driven-development` for features and behaviour-changing fixes, `playwright-best-practices` when Playwright is selected or present, `requesting-code-review` for a distinct final-review gate, and `verification-before-completion` before completion claims. An ordinary combined validation/review pass does not add another reviewer.
- Use `vercel-cli` for Vercel operations, `python-quality` when a Python repository lacks coherent quality gates, and `personal-skill-library` only for this shared skill library.

## Default modes

- Read `caveman` and use `ultra` for chat replies by default. Read `ponytail` and use `ultra` for coding: reuse existing capabilities, minimise code and dependencies, and avoid speculative features.
- Never simplify away requested behaviour, correctness, tests, safety, accessibility, or applicable independent validation. An explicit mode change persists for the task.

## Development defaults

- Define observable acceptance criteria before feature work or behaviour-changing fixes: success, relevant failure and permission cases, persistence, user-visible states, and the proving check. Add a regression test before fixing an existing defect when practical.
- Preserve the existing test stack and version-matched guidance. Do not install a new framework merely because a skill is available.
- New or materially redesigned UI gets a compact direction covering typography, palette, layout, and signature interaction. Preserve established systems for smaller changes. Final visual validation must inspect the running result; early screenshots are conditional on new UI or material redesign.
- When durable shared persistence is required and no provider is specified, default to hosted Supabase. Reuse an intended existing provider or linked project. Planning-only work creates no cloud resources.
- For hosted Supabase, follow `fullstack-delivery/references/supabase-hosted.md`: prefer an unambiguous authenticated organisation, default new UK projects to `eu-west-2`, commit migrations, dry-run then apply with `db push`, generate application types, and configure the linked Vercel project with its URL and publishable key. Never expose elevated keys, passwords, or tokens; start no local Supabase stack, reset linked database, or delete project without explicit request.

## Python quality

- Preserve established tooling. For a new Python service, default to `uv` with committed `uv.lock`, Ruff, pytest, and a pinned type checker when typed boundaries or non-trivial backend logic justify it.
- Provide one `verify` command, or nearest repository convention, covering configured lint, format check, types, tests, and required integration checks. CI uses the lockfile without silently updating it. Keep commit hooks fast; coverage supplements acceptance tests rather than replacing them.

## Delivery and validation

- Follow `fullstack-delivery` for dependency-aware scheduling, capacity use, ownership, resource locks, integration, and deployment. Researchers, implementers, validators, and reviewers are leaves; the lead retains requirements, contracts, shared resources, integration, and final evidence.
- Apply `independent-validation` for risk classification, validator/reviewer separation, evidence scope, reruns, and completion gates. Authentication, authorization, persistence, security, migration, external-integration, reworked, or failed changes retain their stronger gates.
- Required integrated frontend/backend work includes at least one real-backend journey with isolated data. Required cases cannot be skipped, quarantined, filtered out, weakened, or snapshot-refreshed into a pass. Migration and security safeguards remain mandatory.
- Evidence applies only to its recorded snapshot and assumptions. Resolve Critical and Important findings before completion. If independent agents or a required environment are unavailable, report the missing gate and do not claim it passed.

## Git and issues

- New branches use `brownsey_<short-kebab-case-name>` unless the user requests another name; preserve the current branch otherwise.
- Use cohesive Conventional Commits: `<type>(<optional-scope>): <imperative description>`, with a body or `BREAKING CHANGE:` footer when needed. Before committing, inspect staged changes, exclude unrelated files and secrets, and run relevant checks.
- Before creating an issue, search open and closed issues for duplicates. Use a conventional title, state problem and impact, observable acceptance criteria, constraints, and proof. Bug reports include reproduction, expected/actual behaviour, and environment. Reuse repository labels/forms and closing syntax.

## Safety

- Do not infer permission for destructive data changes, production mutations, merging, or deployment beyond the user's request. Resolve exact targets first, keep secrets out of Git/chat/logs, prefer recoverable actions, and preserve unrelated user changes.
