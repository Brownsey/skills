# Testing and independent validation

The goal is a repeatable check against the original requirement. A passing suite is evidence only for what its assertions actually cover. Skills guide test generation and validation; application commands and CI execute the gates.

## Selected skills

- Superpowers `test-driven-development`: red/green/refactor and meaningful test design, including its `writing-good-tests.md` reference.
- Superpowers `requesting-code-review`: dispatch a separate reviewer with the requirements and complete change scope. Its reviewer template is read-only and does not delegate further.
- Superpowers `verification-before-completion`: report observed results rather than unsupported completion claims.
- Currents `playwright-best-practices`: practical browser, API, fixture, accessibility and CI guidance. Load only relevant references; the skill does not require a Currents subscription.

Global instructions supply the additional requirement that validators execute checks independently of implementation authors. Keep these upstream copies unchanged and apply personal workflow choices in `global/AGENTS.md`.

## Pick tests by what they prove

| Layer | What it proves | Typical tools |
| --- | --- | --- |
| Domain/use case | Business rules, expected errors and side-effect decisions | Existing runner; Vitest in a new TypeScript app, pytest for Python |
| React interaction | Visible behavior, form errors, keyboard interaction and UI states | Testing Library with the project's runner and DOM environment |
| Adapter/database | Real schema, serialization, policies and persistence semantics | Integration tests against a local or isolated test database/service |
| HTTP/API | Input validation, status/error mapping, identity and authorization | Existing API test harness or Playwright request fixtures |
| Full application | A real user journey through frontend, backend and required persistence | Playwright against the running app |
| Static/build | Types, lint/import boundaries and deployable build | Existing repository commands |

Use fakes/mocks at external boundaries for isolated tests. A fully mocked suite does not prove database policies, migrations or frontend/backend integration. Keep at least one relevant complete journey connected to the real backend and isolated test data. Do not use production resources to make integration tests easier.

For Next.js, follow the installed version's testing guidance. Async Server Components may require full-app testing rather than being rendered in a unit-test environment. Automated accessibility checks cover only part of usability; include relevant keyboard and interaction assertions.

## Definition-of-done example

Requirement: a signed-in user can create a private item that remains available after refresh.

| Acceptance criterion | Evidence |
| --- | --- |
| Valid input creates an item owned by the verified actor | Use-case/API tests assert outcome and owner |
| Invalid input returns the agreed error and performs no write | Domain/API failure test |
| Refresh retrieves persisted content | Browser journey with real backend |
| A different user cannot read or change the item | API and actual database-policy/adapter checks |
| A failed save shows an accessible error and allows retry | React interaction or browser test |

For each criterion, record the actual test name/path, command and result. Add requirements only when the brief needs them; this example does not mandate authentication for every app.

## Agent ownership and final evidence

Implementation agents use test-first checks as feedback. After the change settles, a fresh frontend validator and a fresh backend validator handle their affected surfaces. For a single-surface change, only that validator is needed. Give them the brief, acceptance criteria, contract, test environment, files and current commands. If needed, give them disjoint test-file ownership to add missing cases.

Validators leave production code and agreed behavior unchanged. A failed assertion is diagnosed against the requirement. Return implementation defects to the implementation owner; correct a faulty test only with an explicit rationale. Prove that a meaningful regression check can detect its target defect, using the pre-fix version or a controlled isolated mutation when appropriate. Do not reset the user's shared checkout for this experiment.

After code and test edits settle, a separate read-only reviewer uses `requesting-code-review` to examine requirement coverage, test quality and actual changes. Review uncommitted changes too when present. The reviewer must not rubber-stamp the implementer's checklist or derive all expected outcomes from the code. Validators/reviewers are leaf agents.

The lead coordinates shared builds, servers, dependencies and test data. Avoid concurrent builds into the same output directory or test runs that delete each other's fixtures. Recheck affected behavior after fixes. Report failures, skips and unavailable environments accurately; keep required cases failing rather than weakening them to make a report green.

## Repeatable application gates

Inspect the existing scripts first. When establishing tooling in a new app, provide documented commands for static checks, unit/component tests, integration tests, browser tests and production build, plus one aggregate verification command. Adapt names to the existing package manager or Python runner; names such as `test:unit`, `test:integration`, `test:e2e` and `verify` are examples. For a Python service without coherent existing gates, use `python-quality` when available.

CI should run the relevant gates on the deliverable revision with isolated test configuration and retain useful failure artifacts. Missing required suites, skipped acceptance tests and commands that fail must not become a successful aggregate result. A local command is not an enforced merge rule until CI and repository requirements are configured. This skills repository does not create those gates in an application that does not exist yet.

## Why the other Claude skills were not copied

The personal architecture skill is portable after separating its Python preferences from the core boundary rules. The old `add-tests` skill hardcodes a model-registration application, fixed test filenames and a policy of fixing the test on every failure. Its generic name hides its narrow scope. Keep that application-specific knowledge with its application.

The old scaffold and style skills prescribe placeholder layers, a custom Result implementation and Python tooling. The lint skill generates a new task dispatcher, has conflicting formatting/version defaults and uses shell syntax unsuitable for PowerShell. Their useful principles are covered by the architecture port, existing repository tooling and this validation workflow. A separate copy would duplicate or conflict with them.

The full Superpowers development controller is unnecessary for this setup; the selected individual skills cover its useful testing/review roles. Microsoft's Playwright planner/generator may be useful within a future app, but its healer can skip tests for broken functionality. Skipping required behavior cannot satisfy this workflow. The current Anthony Fu Vitest skill targets a beta major version, so use official, version-matched runner guidance initially.

Sources: [Superpowers](https://github.com/obra/superpowers), [Currents Playwright skill](https://github.com/currents-dev/playwright-best-practices-skill), [Playwright test agents](https://playwright.dev/docs/test-agents), [Next.js testing](https://nextjs.org/docs/app/guides/testing), [Testing Library](https://testing-library.com/docs/guiding-principles/).
