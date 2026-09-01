## Personal skill use

- Before substantive work, check the available skill descriptions and read the skills that clearly apply.
- Briefly name each skill used and explain why it applies.
- Follow the applicable workflow and verify its relevant outputs before reporting completion.
- If a required skill is unavailable, explain the limitation and continue with useful work where possible.
- Keep application-specific conventions and commands in that application's repository.

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
- Ponytail minimises implementation overhead; it must not remove required tests, appropriate fixtures, test tooling, or independent checks. Documentation-only edits and trivial nonbehavioral changes need relevant validation, not invented application tests.

## Dedicated validation agents

- Required checks run in dedicated subagents, separate from the agents that implemented the behavior. For frontend/backend changes, give each affected side its own validation agent. A single affected side needs only its corresponding validator. Use available slots sequentially if necessary; implementation workers' local tests are useful feedback but do not replace this gate.
- Give validators the original acceptance criteria, API contract, relevant files, actual change scope (including uncommitted changes), repository commands and isolated test environment. Provide concise context rather than the lead's conversation history. Assign disjoint test files and coordinate shared installs, builds, servers and databases centrally.
- Frontend validation covers applicable component interactions, loading/empty/error states, accessibility and the browser journey. For substantive UI changes, inspect the running app and desktop/mobile screenshots against the agreed design: hierarchy, spacing, readable content, responsive layout and clear actions. Use `web-design-guidelines` for UI guideline reviews; report unavailable visual checks rather than inferring visual quality from passing tests. Backend validation covers domain rules, input validation, authorization, persistence and real adapter/API integration. Reuse the existing test stack. At least one integrated journey must use the real backend when both sides form the deliverable.
- Validators execute checks and may add missing tests in their assigned files. They do not change production code or acceptance criteria. Classify failures against the requirement: production defects return to the implementation owner; a faulty test may be corrected with an explicit reason. Never skip required cases, weaken assertions, refresh snapshots or lower thresholds merely to obtain a pass.
- After implementation and test changes settle, use `requesting-code-review` to dispatch a separate read-only reviewer for requirement coverage, test quality and code defects. Give the actual base and final change scope; do not assume `HEAD~1` includes the work. A reviewer is not asked to approve their own implementation or tests.
- Validators and reviewers are leaf agents: do not recursively dispatch more agents. Their return includes checks/commands, exit status, failures or skips, requirement coverage, findings and the revision or working-tree state tested. Do not treat a bare success claim as evidence.
- Use `verification-before-completion` before reporting completion. Evidence must cover the final relevant state; rerun checks invalidated by fixes. Evidence from a dedicated validator for unchanged code can be reused without running the same command again in every message. Repeat tests for a concrete flakiness/concurrency risk rather than imposing an arbitrary repetition count. Skipped, quarantined, filtered-out or flaky required cases do not satisfy acceptance. Resolve substantive findings before declaring the work ready.
- If subagents or a required test environment are unavailable, report the missing gate and perform useful available checks; do not claim independent validation passed. These instructions govern workflow, while enforceable merge/deploy checks must be configured in the application repository's CI. They do not require a manual PR or authorize merging/deployment by themselves.
