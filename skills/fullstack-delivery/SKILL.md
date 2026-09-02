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

## Brief to plan

1. Preserve the original brief and supplied repository. Extract mandatory requirements and define done for each: observable success, relevant failure/permission cases, test layer, check command and owner. Expected results come from the brief rather than the generated implementation. Keep optional features separate; do not add speculative scope while refining the prompt.
2. Clarify only decisions that block correct work. Record reversible assumptions and proceed within the authorised scope. If asked only to plan or optimise a prompt, deliver that artifact without starting implementation or deployment.
3. Follow the provided stack. When free choice applies, prefer the user's familiar stack; the baseline here is Next.js App Router, TypeScript, React UI and Route Handlers in one Vercel project. Use version-matched docs and retain the dependency lockfile. When the deliverable includes a new Python service or an existing Python service lacks repeatable gates, use `python-quality` when available.
4. Define the shared API contract before splitting work: methods, paths, input/output types, status codes, error shapes, IDs, validation and persistence semantics. Keep shared types free of server-only imports. Concrete request/response examples are useful; writing the entire implementation in the plan is not.
5. Produce a concise plan covering requirements, the selected profile, file ownership, dependencies and verification. Plan detail should match genuine complexity; do not write implementation code twice.

If durable storage is required, use a deployment-compatible durable service. Process memory, runtime files and browser storage are not substitutes for required shared backend persistence. Keep secrets server-side. Authentication and external services follow the brief.

## Parallel implementation

For an implementation spanning both frontend and backend, default to a lead plus two parallel workers once the scaffold and shared contract are stable. Parallelise only when tools are available and file ownership, dependencies and runtime state can be separated safely. Use one sequential implementation worker when the request affects one surface, the work is tightly coupled, or coordination would cost more than it saves. Honour an explicit request for sequential work. Workers, researchers, validators and reviewers are leaf agents and never delegate.

| Owner | Scope |
| --- | --- |
| Lead | Scaffold, shared API/types, package files and lockfile, framework config, integration, deployment, validation coordination and final evidence |
| Frontend | Named pages, components, UI styles, client API calls, loading/empty/error states and local tests |
| Backend | Named API routes, server validation, business logic, required storage/migrations and local tests |

Feature-surface production implementation belongs to the workers. The lead edits only shared scaffold, contracts, dependencies, framework configuration and integration code, avoiding duplication of worker-owned code. If only one application surface is affected, use one implementation worker and retain the corresponding independent validator.

Assign disjoint file lists for the actual app. A broad `app/` or `lib/` assignment can overlap; avoid it. Only the lead changes shared files or dependencies. Route contract changes through the lead and notify both workers before using them.

Give each worker its relevant requirements, profile, contract, owned files, assumptions, acceptance checks and expected handoff. Keep the full brief accessible without forwarding irrelevant conversation history. Require changed files, checks run and blockers in the handoff.

For new UI or a substantial redesign, the frontend worker uses `frontend-design` when available to establish a compact visual direction before coding. It shares that direction with the lead and frontend validator; preserve existing design systems and the main user task.

Frontend fixtures may unblock UI work behind the agreed API boundary. Label them as temporary and replace them with the real backend before delivery. Integrate the first real user journey early, then expand required behaviour.

When material repository or external research is needed, dispatch a bounded read-only leaf research subagent while implementation continues on unaffected work. Give it the exact uncertainty, authoritative-source preference and expected evidence. Settle findings that affect the shared contract, dependency choice, security or data model before workers implement that decision.

In a shared workspace, workers do not independently commit, reset, stash, change branches or run competing production builds. The lead coordinates shared build outputs and dependency installs. If using worktrees, establish the integration method before dispatch. The lead inspects combined changes for ownership and integration conflicts and tests combined behaviour; independent validators and reviewers assess correctness and quality.

## Independent validation

Apply the dedicated validation-agent gate from the shared global instructions. After implementation, allocate separate frontend and backend validators for the affected surfaces; these must be distinct from the implementation authors. Run the validators concurrently when slots, build outputs, services and test data are independent; otherwise run them sequentially. Give them the original acceptance criteria and contract, not just the implementation summary.

Validators run the required checks and may add missing tests in assigned test files. Production fixes return to the implementation owner. Review and audit work runs inside dedicated validation/review subagents, never in the implementation worker. The lead applies `requesting-code-review` to dispatch the final read-only assessment of the settled code and tests. Verify an integrated journey against the real backend and required persistence. Recheck affected behavior after fixes; a green mocked suite or a skipped acceptance case is insufficient.

When available, use `test-driven-development`, `playwright-best-practices` and `verification-before-completion` for their relevant roles. Use `hexagonal-architecture` for meaningful business boundaries. See [testing workflow](references/testing-workflow.md) when selecting test layers, defining done or configuring repeatable application checks. Use `python-quality` for Python-specific lint, format, type, test, hook and CI setup when available.

## Deploy and verify

When deployment is requested, use the intended Vercel account/project and a supported deployment path. Prefer a working authenticated CLI. Use `vercel-cli` guidance if available and check installed CLI help for uncertain flags. Do not deploy when the request is planning-only.

When durable persistence is required and Supabase is selected by the brief or personal defaults, read [hosted Supabase delivery](references/supabase-hosted.md). Provision and configure the remote project as part of an authorised implementation; planning-only work stops before cloud mutations.

Deploy a coherent scaffold early. Coordinate edits while packaging a deployment or deploy a committed snapshot. Record the latest verified URL and corresponding revision. Configure environment variables for the correct deployment environment. Read a failed build/deploy's decisive error before retrying.

Prioritise required behaviour, integration and a working deployment. Keep speculative refactors outside scope. Preserve unfinished work and disclose gaps; do not claim incomplete requirements are complete.

Before reporting completion:

- Map required behaviour to performed checks or disclosed gaps.
- Run required build/type/lint checks and relevant tests. Repeat checks when subsequent changes invalidate their evidence, rather than merely to repeat a status update.
- Use the available Browser skill to exercise the deployed main journey and relevant error/empty/loading states. Verify required persistence across requests or refreshes.
- Verify the deliverable URL through its intended access path. A CLI success message is not proof of a working or accessible application.
- Provide a concise README or handoff with setup, environment variable names, URL, checks and actual trade-offs. Explain the implementation when asked, even in terse chat mode.

## Supporting guidance

Use `vercel-react-best-practices` for applicable React rules and run `web-design-guidelines` in the frontend validation/review subagent for a requested UI review when available. Load only references needed by the current task. This standalone workflow does not require the Superpowers orchestration chain.
