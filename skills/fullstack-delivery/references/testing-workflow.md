# Testing workflow

Choose the smallest set of test layers that proves the original requirements. A passing suite is evidence only for its assertions. Use existing repository tooling and version-matched guidance.

## Map criteria to layers

For each mandatory criterion, record expected behaviour, test name/path, command, result, and tested snapshot. Include success plus relevant validation, failure, permission, persistence, loading, empty, and recovery states.

| Layer | What it proves | Typical tools |
| --- | --- | --- |
| Domain/use case | Business rules, expected errors, side-effect decisions | Existing runner; Vitest for a new TypeScript app, pytest for Python |
| React interaction | Visible behaviour, form errors, keyboard use, component states | Testing Library with repository runner and DOM environment |
| Adapter/database | Schema, serialization, constraints, policies, persistence | Integration tests against isolated database/service data |
| HTTP/API | Input validation, status/error mapping, identity, authorization | Existing API harness or Playwright request fixtures |
| Full application | User journey across frontend, backend, and persistence | Playwright against running app |
| Static/build | Types, lint/import boundaries, deployable output | Repository scripts |

Use `test-driven-development` for feature work and behaviour-changing fixes. For an existing defect, add a regression test before the fix when practical and show that it fails for the defect, without resetting or damaging the user's shared checkout. Tests assert behaviour from the requirement, not incidental implementation details.

Use fakes or mocks at external boundaries for fast isolated tests. Mocked tests do not prove database policies, migrations, real adapters, or frontend/backend integration. When frontend and backend form the deliverable, keep at least one relevant complete journey connected to the real backend and isolated non-production data. Verify required persistence across a refresh or later request.

For Next.js, follow the installed version's guidance; Async Server Components may need full-app rather than unit rendering. Automated accessibility checks are partial evidence, so include relevant keyboard and interaction assertions. For a browser-capable UI app, reuse its established browser runner; when none exists, the main skill automatically adds Playwright and a minimal main-journey smoke test. Use `playwright-best-practices` for Playwright setup and tests.

## Example criterion map

Requirement: a signed-in user can create a private item that remains after refresh.

| Acceptance criterion | Evidence |
| --- | --- |
| Valid input creates an item owned by verified actor | Use-case/API tests assert result and owner |
| Invalid input returns agreed error and performs no write | Domain/API failure test |
| Refresh retrieves persisted content | Browser journey with real backend |
| Another user cannot read or change item | API plus actual policy/adapter check |
| Failed save shows accessible retryable error | React interaction or browser test |

This example does not require authentication in unrelated apps; add only criteria demanded by the brief.

## Sensitive boundaries

- Authentication and authorization need negative and cross-actor cases at the actual enforcement boundary.
- Database work must validate schema, policy, persistence, and migration effects against an isolated or approved target. Inspect or dry-run migrations before applying when supported; never use production data for convenience.
- External integrations need deterministic contract/error tests plus a controlled real-adapter check when the requirement depends on live behaviour.
- Keep credentials out of fixtures, logs, snapshots, and repositories.

## Repeatable gates

Inspect existing scripts first. A new app should document commands for static checks, unit/component tests, integration tests, browser tests, production build, and one aggregate verification command. Adapt names to the repository; `test:unit`, `test:integration`, `test:e2e`, and `verify` are examples, not mandates. For Python without coherent gates, use `python-quality`.

CI should run relevant gates on the deliverable revision with isolated configuration and useful failure artifacts. Missing suites, failing commands, and skipped, quarantined, filtered-out, flaky, or weakened required cases cannot produce a successful aggregate result. A local command is not an enforced merge rule until CI and repository protection require it.

Evidence stays reusable while tested files, dependencies, contract, environment, migration, and data assumptions remain unchanged. Rerun affected checks after change; do not repeat unchanged checks for ceremony. Report unavailable environments and skips accurately.
