---
name: fullstack-delivery
description: Plan and deliver full-stack apps with light, medium or high implementation depth, shared API contracts, parallel frontend/backend work and Vercel deployment. Use for app briefs or execution-prompt refinement; planning-only requests stop at the plan.
---

# Full-stack delivery

Deliver the original brief's required behaviour with minimal implementation and clear evidence. Shorter code and replies must preserve requirements, correctness and requested explanations. Use [launch-prompt.md](references/launch-prompt.md) when the user wants a reusable execution prompt.

## Profile

Use the requested profile; default to `light`. Profiles control implementation depth while preserving all mandatory requirements. Read the selected section of [profiles.md](references/profiles.md), plus its shared baseline.

| Profile | Intent |
| --- | --- |
| light | A focused, complete implementation with a small dependency set and direct architecture |
| medium | Broader workflows with reusable boundaries, structured data changes and stronger integration coverage |
| high | Operationally demanding apps with justified design decisions, failure handling and evidence for reliability requirements |

All profiles support real persistence, authentication and external integrations when required. A profile never authorises adding unrequested product features. If requested scope exceeds the selected approach, explain the concrete implication without silently discarding requirements or switching profiles.

When the user asks for a rapid or time-boxed implementation, enable **rapid delivery mode** from the shared instructions. This is a scheduling overlay, not another profile: it keeps the chosen depth and acceptance criteria while starting independent work and feedback sooner. Show the user the compact contract, priorities and worker split at dispatch; route later steering through the lead while Codex continues agent scheduling and file ownership.

## Brief to plan

Interrogate the brief once before dispatch. This is a compact intake inside this workflow, not a separate planning controller.

Parallelise distinct intake evidence when useful: a read-only repository scout for existing constraints, technical researchers for external facts, and a UI/reference analyst when visual evidence is supplied or central. Do not create several agents to reinterpret the same brief. Each returns evidence and implications; the lead awaits relevant intake evidence, then reconciles it into requirements, questions and contracts.

1. Read the complete brief and inspect the supplied repository, scripts, lockfile, environment templates and deployment configuration before questioning the user. Run a non-mutating preflight for package-manager and lockfile consistency, required CLI availability/authentication, environment-variable names, database/deployment access and intended build/test commands. Preserve the brief and repository as source material; do not replace explicit requirements with generated preferences.
2. Give each mandatory requirement a stable ID. Separate mandatory, optional and out-of-scope work. Define observable success, relevant failure/permission cases, persistence and user-visible states, test layer, check command and owner. Expected results come from the brief rather than the implementation.
3. Record initial contradictions, consequential unknowns and reversible assumptions. Identify the highest-risk unknowns and dispatch bounded research for external facts while unaffected intake or, for implementation requests, scaffold work continues. Settle findings that affect the contract, dependency choice, security or data model before implementing that decision.
4. After relevant intake evidence returns, record `questions: none` or `questions: one-batch` with the effect of each unanswered blocker. Ask at most one compact batch, only for decisions that still block correct work or materially change the contract. Resolve preference-level choices with the repository, familiar stack and reversible assumptions so implementation can continue; workers do not reopen settled preferences.
5. Follow the provided stack. When free choice applies, prefer the user's familiar stack; the baseline here is Next.js App Router, TypeScript, React UI and Route Handlers in one Vercel project. Use version-matched docs and retain the dependency lockfile. When the deliverable includes a new Python service or an existing Python service lacks repeatable gates, use `python-quality` when available.
6. Define the shared API and UI contracts before splitting work: methods, paths, input/output types, status codes, error shapes, IDs, validation and persistence semantics; plus page structure, component boundaries and required states where UI workers split. Keep shared types free of server-only imports. Concrete examples are useful; writing the implementation twice is not.
7. Publish one canonical kickoff packet: requirement IDs, assumptions, selected profile and delivery mode, contract version, priorities, optional cut order, exact file/test ownership, shared-resource locks, delivery deadline or constraint, validation reserve and evidence for done. Resource locks name the owner of dependency installation, build output, dev server/port, database namespace/migrations, preview deployment and aggregate gate. If asked only to plan or optimise a prompt, return this artifact without implementation or deployment.

Keep the kickoff packet canonical. For a run at material risk of compaction, interruption or handoff, mirror requirement status, rulings, ownership, evidence, deployment URL and next action in one concise git-ignored run ledger. Do not create a large planning artifact for a short stable run.

If durable storage is required, use a deployment-compatible durable service. Process memory, runtime files and browser storage are not substitutes for required shared backend persistence. Keep secrets server-side. Authentication and external services follow the brief.

## Parallel implementation

For an implementation spanning both frontend and backend, build a dependency graph once the scaffold and shared contract are stable. Assign one worker to each genuinely independent critical-path surface whose files, inputs and runtime state can be separated safely. Agent capacity is not the target: add workers while they shorten the critical path, and stop splitting when coordination or shared state would dominate. Use one sequential implementation worker when the request affects one surface, the work is tightly coupled, or coordination would cost more than it saves. Honour an explicit request for sequential work. Workers, researchers, validators and reviewers are leaf agents and never delegate.

Admit a worker only when its prerequisite contract is stable, write set is disjoint, runtime and test data can be isolated, result has an observable acceptance check and parallel execution shortens the critical path. Duplicate attempts are reserved for hard diagnosis or alternative designs with an objective selector such as tests, measured output or an independent reviewer. Keep the lead's context to the brief, contracts, decisions, dependency graph, acceptance state and compact summaries; raw exploration, logs and stack traces stay with workers.

Use the strongest justified reasoning for contract decisions, difficult integration and high-risk review. Prefer faster lower-effort agents for bounded search, file mapping, repetitive checks, deterministic test execution and structured summaries. Do not maximize effort for every role without evidence that it improves the result.

Before dispatch, scan requirement-to-task coverage, API/UI/type agreement, overlapping file or test ownership and shared-resource locks. Resolve contradictions centrally without adding another user approval gate.

| Owner | Scope |
| --- | --- |
| Lead | Scaffold, shared API/types, package files and lockfile, framework config, integration, deployment, validation coordination and final evidence |
| Frontend | One or more disjoint page, component, interaction or visual-foundation surfaces with local tests |
| Backend | One or more disjoint API, domain, adapter or persistence surfaces with local tests |

Feature-surface production implementation belongs to the workers. The lead edits only shared scaffold, contracts, dependencies, framework configuration and integration code, avoiding duplication of worker-owned code. If only one application surface is affected, use one implementation worker and retain the corresponding independent validator.

Assign disjoint file lists for the actual app. A broad `app/` or `lib/` assignment can overlap; avoid it. Only the lead changes shared files or dependencies. Route contract changes through the lead and notify both workers before using them.

Give each worker its relevant requirements, profile, contract, owned files, assumptions, acceptance checks and expected handoff. Keep the full brief accessible without forwarding irrelevant conversation history. Require changed files, checks run and blockers in the handoff.

For new UI or a substantial redesign, the frontend worker uses `frontend-design` when available to establish a compact visual direction before coding. It shares that direction with the lead and frontend validator; preserve existing design systems and the main user task.

For UI-heavy work, the lead may use a visual-foundation worker plus interaction workers for disjoint screens or flows after recording typography, palette, tokens, breakpoints, page structure, component names/props, required states and the signature interaction. Visual foundations include layout, tokens, shared UI primitives, static assets and purposeful motion; interaction surfaces include feature screens, forms, client data flow, states and component tests. Use `animate` only when motion serves feedback, spatial continuity or state understanding. Keep coupled files and components under one owner even when more agents are available.

As soon as the primary journey renders, open the real app and capture an early desktop/mobile artifact or preview. Apply the highest-impact steering while backend and secondary work continue. Frontend implementation feedback is useful but does not replace independent frontend validation.

Frontend fixtures may unblock UI work behind the agreed API boundary. Label them as temporary and replace them with the real backend before delivery. Integrate the first real user journey early, then expand required behaviour.

When material repository or external research is needed, dispatch a bounded read-only leaf research subagent while implementation continues on unaffected work. Give it the exact uncertainty, authoritative-source preference and expected evidence. Settle findings that affect the shared contract, dependency choice, security or data model before workers implement that decision.

In a shared workspace, workers do not independently commit, reset, stash, change branches or run competing production builds. The lead coordinates shared build outputs and dependency installs. If using worktrees, establish the integration method before dispatch. The lead inspects combined changes for ownership and integration conflicts and tests combined behaviour; independent validators and reviewers assess correctness and quality.

## Independent validation

Apply the dedicated validation-agent gate from the shared global instructions. Allocate separate frontend and backend validators for the affected surfaces; these must be distinct from the implementation authors. Normal delivery may start them after implementation settles; rapid delivery follows the surface pipeline below. Run the validators concurrently when slots, build outputs, services and test data are independent; otherwise run them sequentially. Give them the original acceptance criteria and contract, not just the implementation summary.

Validators run the required checks and may add missing tests in assigned test files. Production fixes return to the implementation owner. Review and audit work runs inside dedicated validation/review subagents, never in the implementation worker. The lead applies `requesting-code-review` to dispatch the final read-only assessment of the settled code and tests. Verify an integrated journey against the real backend and required persistence. Recheck affected behavior after fixes; a green mocked suite or a skipped acceptance case is insufficient.

In rapid delivery mode, pipeline validation rather than treating it as one final phase. Start a surface validator as soon as its implementation handoff and contract inputs are stable and a slot is free, provided its services, build output and test data are independent of unfinished work. Early validation covers independent criteria; reactivate the same validator for integration-dependent checks. Run the cheapest criterion-specific checks first, return defects immediately with a concise reproduction to the original owner, then run one complete surface gate after fixes settle. Reuse the lead-managed install, long-lived server or preview and isolated fixtures where safe. Assign aggregate build/static checks to one validator and do not duplicate unchanged green checks.

The frontend validator combines applicable browser interaction, desktop/mobile screenshots, accessibility, UI guideline, React performance and motion checks in one pass. The backend validator combines domain, input, authorization, persistence, adapter and selected security or architecture checks. After both surfaces settle, run one real integrated journey. The final reviewer covers requirements, test quality and diff defects without repeating completed specialty audits. It may overlap with a preview deployment or URL check of the same tested snapshot when outputs and test data do not conflict and no irreversible migration runs; Critical or Important findings invalidate the affected evidence and deployment result.

Record criterion-level evidence as it passes: tested snapshot, command, result and artifact or URL where applicable. The final gate compiles this existing evidence and reruns only invalidated checks rather than reconstructing the run.

When available, use `test-driven-development`, `playwright-best-practices` and `verification-before-completion` for their relevant roles. Use `hexagonal-architecture` for meaningful business boundaries. See [testing workflow](references/testing-workflow.md) when selecting test layers, defining done or configuring repeatable application checks. Use `python-quality` for Python-specific lint, format, type, test, hook and CI setup when available.

## Deploy and verify

When deployment is requested, use the intended Vercel account/project and a supported deployment path. Prefer a working authenticated CLI. Use `vercel-cli` guidance if available and check installed CLI help for uncertain flags. Do not deploy when the request is planning-only.

When durable persistence is required and Supabase is selected by the brief or personal defaults, read [hosted Supabase delivery](references/supabase-hosted.md). Provision and configure the remote project as part of an authorised implementation; planning-only work stops before cloud mutations.

Deploy a coherent scaffold early. Coordinate edits while packaging a deployment or deploy a committed snapshot. Record the latest verified URL and corresponding revision. Configure environment variables for the correct deployment environment. Read a failed build/deploy's decisive error before retrying.

Prioritise required behaviour, integration and a working deployment. Keep speculative refactors outside scope. Preserve unfinished work and disclose gaps; do not claim incomplete requirements are complete.

In a time-boxed run, derive a validation reserve from observed build, browser, deployment and review duration; do not assume a universal minute split. When the reserve boundary begins, stop opening new work and cut optional features, polish, refactors and speculative tests in the recorded order. Completion still requires every mandatory criterion, a real-backend integrated journey, no required skips, no unresolved Critical or Important findings and a verified URL when deployment is required.

Before reporting completion:

- Map required behaviour to performed checks or disclosed gaps.
- Run required build/type/lint checks and relevant tests. Repeat checks when subsequent changes invalidate their evidence, rather than merely to repeat a status update.
- Use the available browser tooling to exercise the deployed main journey and relevant error/empty/loading states. Verify required persistence across requests or refreshes.
- Verify the deliverable URL through its intended access path. A CLI success message is not proof of a working or accessible application.
- Provide a concise README or handoff with setup, environment variable names, URL, checks and actual trade-offs. Explain the implementation when asked, even in terse chat mode.

## Supporting guidance

Use `vercel-react-best-practices` for applicable React rules and run `web-design-guidelines` in the frontend validation/review subagent for a requested UI review when available. Load only references needed by the current task. Do not run a separate Superpowers planning or orchestration chain before this workflow. Use the selected Superpowers skills inside it: `test-driven-development` during implementation, `requesting-code-review` for the settled final review and `verification-before-completion` for final evidence.
