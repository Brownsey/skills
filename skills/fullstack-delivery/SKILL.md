---
name: fullstack-delivery
description: Plan and deliver full-stack apps with light, medium or high implementation depth, Sol-primary delegation, stable API/UI contracts, risk-based validation, and Vercel deployment. Use for app briefs or execution-prompt refinement; planning-only requests stop at the plan.
---

# Full-stack delivery

Deliver the brief's required behaviour with the smallest coherent implementation and criterion-level evidence. By default, maximise useful parallelism and minimise wall-clock delivery time without fragmenting coupled work or weakening gates. Use [launch-prompt.md](references/launch-prompt.md) only when the user wants a reusable execution prompt.

## Select depth

Use the requested profile; default to `light`. Read the shared baseline and selected section of [profiles.md](references/profiles.md).

| Profile | Intent |
| --- | --- |
| light | Focused complete implementation, direct architecture, small dependency set |
| medium | Broader workflows, reusable boundaries, structured data changes, stronger integration coverage |
| high | Operationally demanding app with justified failure handling and reliability evidence |

Profiles change implementation depth, not mandatory requirements, safety, validation, or the default time-first objective. If the scope strains the selected profile, explain the concrete implication without silently dropping work or changing profile. For a rapid or time-boxed request, keep the profile and criteria, estimate a validation/deployment reserve from observed check durations or repository history. When neither exists, label a conservative estimate and revise it after the first measured gates. Stop optional work at the explicit cut boundary.

## Turn the brief into a contract

Inspect the complete brief, repository, scripts, lockfile, environment templates, and deployment configuration before asking questions. Run non-mutating preflight checks for the package manager, intended build/test commands, required CLI/auth state, environment-variable names, and database/deployment access.

1. Give mandatory requirements stable IDs. Separate optional and out-of-scope work. For each requirement define observable success, relevant failure/permission cases, persistence and user-visible states, and the proving check.
2. Record contradictions, consequential unknowns, and reversible assumptions. Parallelise bounded repository, technical-risk, and UI-reference discovery. Await only evidence that can change the affected contract; continue independent preflight or scaffold work while research runs. Ask at most one compact batch of questions only for decisions that still block correct work or materially change the contract.
3. Follow the required stack. With free choice, prefer the user's familiar stack; baseline is Next.js App Router, TypeScript, React, and Route Handlers in one Vercel project. Preserve the lockfile and use version-matched guidance.
4. Define shared API and UI contracts before splitting work: methods, paths, input/output types, status codes, error shapes, IDs, validation, authorization and persistence semantics; page/component boundaries and required loading, empty, error, success, and permission states.
5. Publish one compact kickoff packet: requirement IDs, assumptions, profile/mode, contract version, priorities and optional cut order, dependency DAG, stable-contract boundaries, ownership, shared-resource locks, validation risk/gate, deployment target, and evidence for done. Planning-only requests end here without edits, provisioning, or deployment.

Keep the brief and contract accessible by path when possible. Use a small git-ignored run ledger only when interruption or compaction risk justifies it.

## Implement

Prefer direct architecture and existing capabilities. Durable shared data needs deployment-compatible persistence; process memory, runtime files, and browser storage do not satisfy that requirement. Keep secrets server-side.

When explicit model routing is available, use `gpt-6-astra` for architecture and cross-system trade-offs, plus exceptional unresolved correctness decisions. Use `gpt-6-sol` for other substantive delegated work: planning, implementation, test authoring, integration, judgment-based validation, and final review. Return implementation to Sol after Astra settles the architecture or decision. Start at the lowest reasoning effort adequate for each packet and raise it only for ambiguity, consequence, or failed evidence-led work. Use `gpt-6-luna` at low reasoning only for bounded mechanical discovery, deterministic browsing or interactive setup with settled non-secret inputs, evidence capture, and execution of checks whose criteria are already fixed. Luna does not edit code, choose architecture, interpret unexpected states, handle secrets, or judge correctness. Explicit user/runtime restrictions override this routing.

An authorised implementation request using this skill authorises in-scope subagent dispatch when collaboration tools are available; explicit user or runtime restrictions still win. Map ready packets from the dependency DAG, discover effective free subagent capacity, and dispatch `min(free slots, ready independent packets)`. Refill capacity immediately as packets finish. Packets need stable contracts, disjoint files, isolated runtime/test state, and a mandatory criterion or material uncertainty to resolve. Keep one implementation owner only for trivial work or safely inseparable surfaces, and record that reason. The lead owns requirements, contracts, shared resources, integration, scheduling, and final evidence rather than feature surfaces.

Implementation packets include the relevant requirements, contract version, owned files, prohibited shared resources, checks, and expected result. Name lock owners for dependency installation, server/port, build output, database/migration namespace, preview deployment, and aggregate gate when those resources exist. Give concurrent tests unique data namespaces; serialize only actual resource conflicts. Workers do not independently change branches, reset/stash the shared checkout, install competing dependencies, or run conflicting builds. Keep the handoff compact: `STATE`, `FILES`, `CRITERIA`, `CHECKS`, `FINDINGS`, `RUNTIME`, `ASSUMPTIONS`.

Use `test-driven-development` for feature work and behaviour-changing fixes. Read [testing-workflow.md](references/testing-workflow.md) when choosing test layers, real-backend evidence, or repeatable gates. For a Python service that lacks coherent quality tooling, use `python-quality` when available.

For a browser-capable app with user-facing UI, inspect existing browser-test tooling. Reuse an established capable runner. If none exists, automatically add Playwright with the repository's package manager, install only the required browser runtime, add minimal configuration and a smoke journey for the main user path, and wire it into the repository's browser-test and aggregate verification commands. Use `playwright-best-practices`. Give installation, configuration, and test authoring to Sol; Luna may run a settled journey and capture evidence once setup and expected results are fixed. Do not add Playwright to backend-only, non-browser, or planning-only work, and do not replace a working browser runner merely to standardise tooling.

For new UI or a material redesign, use `frontend-design` to set a compact typography, palette, layout, and signature-interaction direction before implementation. Once the main journey renders, capture an early desktop/mobile view and correct major direction errors. Preserve the existing system for smaller changes; those changes do not require early screenshots. Use `animate` only when motion serves feedback or state understanding and include reduced-motion behaviour.

Temporary frontend fixtures may unblock UI work behind the agreed API contract. Label and replace them before delivery. Integrate the first real user journey early.

## Validate by risk

Use `independent-validation` to classify and run the gate:

- trivial documentation, non-behavioural configuration, or readily reversible changes: lead targeted check;
- ordinary substantive single-surface changes: one independent combined validation/review pass;
- high-risk, multi-surface, authentication, authorization, persistence, security, migration, external-integration, reworked, or failed changes: separate affected-surface validators and a distinct final reviewer.

Give validators the original criteria and contract, not only the implementation summary. Required frontend/backend delivery includes at least one relevant integrated journey through the real backend and required persistence with isolated non-production data. A mocked suite or skipped required case is insufficient.

Pipeline independent validation as each surface stabilises. Run the cheapest criterion-specific checks first. Parallelise validators only when their services, build outputs, databases, and test data are isolated. After a fix, the same validator reruns the failed and dependent evidence; unaffected evidence remains valid for its recorded snapshot.

Final UI validation inspects the running app at relevant desktop/mobile sizes, core interaction states, accessibility/keyboard behaviour, and the agreed visual direction. Combine compatible UI guideline, React performance, accessibility, and motion checks by surface. Use `requesting-code-review` for the distinct final reviewer in the high-risk gate, not for an additional pass after ordinary combined validation/review. Then use `verification-before-completion` to compile valid evidence. Rerun only checks invalidated by changed code, tests, dependencies, contract, environment, migration, or data assumptions.

The final read-only review may overlap a safe preview build, deployment, and URL verification only when all use the same immutable snapshot and no irreversible migration runs. A Critical or Important finding invalidates affected deployment evidence until the corrected snapshot is rebuilt and reverified.

## Persist safely

When durable storage is required and the brief does not name a provider, use hosted Supabase. Read [supabase-hosted.md](references/supabase-hosted.md) before provisioning, linking, migrating, or configuring deployment. Reuse an intended existing provider or linked project. Planning-only work performs no cloud mutation.

Commit migrations and inspect or dry-run them before applying when supported. Validate schema, policies, authorization, and persistence against an isolated or approved target. Never expose elevated keys, database passwords, or access tokens; reset or delete no linked database/project without explicit authorization.

## Deploy and verify

Deploy only when requested. Use the intended Vercel account/project and authenticated path; read `vercel-cli` guidance when needed. Configure environment variables for the correct environment, inspect the decisive error before retrying a failure, and record the URL with its tested revision or snapshot.

Before completion:

- map every mandatory requirement to valid evidence or an explicit gap;
- run required build, type, lint, test, and integration gates;
- exercise the deployed main journey and relevant loading, empty, error, and permission states;
- verify persistence across requests or refreshes when required;
- verify the URL through its intended access path; a CLI success message alone is insufficient;
- resolve Critical and Important findings and confirm no required case was skipped;
- provide concise setup, environment-variable names, URL, checks, and actual trade-offs.

Do not claim an incomplete requirement, unavailable environment, or missing independent gate passed.
