---
name: fullstack-efficient
description: "Apply a token-first model, context, and dispatch overlay to full-stack delivery: Astra 6 for architecture, Sol 6 for other substantive work, and Luna 6 for bounded mechanical discovery and deterministic browsing. Use when requested by name or when an app brief asks for tiered models or token-efficient delivery."
---

# Full-stack efficient

Use [fullstack-delivery](../fullstack-delivery/SKILL.md) for the delivery workflow. This skill is a model, context, and dispatch overlay. It explicitly replaces the base skill's time-first dispatch breadth with a token-first objective: minimise total measured tokens or credits per accepted criterion or completed task, including required validation and rework. Keep token counts, desktop credits, and API billing separate. When usage is unavailable, use labelled structural proxies rather than claiming savings. Retain the selected profile, contracts, resource safety, `independent-validation` risk gate, persistence safeguards, and definition of done.

## Route work

| Work | Model | Default reasoning |
| --- | --- | --- |
| Narrow read-only mechanical discovery; bounded deterministic web search, browser navigation, evidence capture, reversible interactive setup, and settled check execution | `gpt-6-luna` | low |
| Brief interrogation, acceptance criteria, contracts, decomposition, and consequential replanning within the settled architecture | `gpt-6-sol` | medium |
| Routine implementation, direct CRUD/forms, deterministic fixes, scaffold/config changes, test authoring, and integration | `gpt-6-sol` | low |
| Substantial implementation and tests: complex state, concurrency, transactions, authorization-sensitive work | `gpt-6-sol` | medium |
| Architecture, cross-system trade-offs, and exceptional unresolved correctness decisions | `gpt-6-astra` | high |
| Judgment-based validation, specialty audits, and final review | `gpt-6-sol` | medium |

Route by uncertainty and consequence, not file count or frontend/backend labels.

- Luna returns paths, locations, counts, copied facts, or evidence from a settled browser flow. It may perform bounded deterministic web/computer-use steps when the target, authorization, non-secret inputs, expected state, and stopping condition are already clear. It does not edit code; access, receive, handle, expose, or infer secrets; make consequential choices; interpret ambiguity; judge correctness; or continue after an unexpected state.
- Transfer secret-bearing steps, ambiguous browsing, interactive setup needing interpretation, configuration/code edits, and correctness judgment to Sol. Sol owns all substantive work, with effort matched to difficulty.
- Astra owns architecture, cross-system trade-offs, and exceptional unresolved correctness decisions. It returns a decision, contract, or guidance for Sol; it does not own production code.
- Sol owns the canonical plan and judgment-based validation/review. Do not create competing plans. An explicit user model choice or runtime restriction still wins.

Retain `fullstack-delivery`'s automatic Playwright bootstrap for eligible browser-capable UI apps. When no capable browser runner exists, batch Playwright installation, minimal configuration, and smoke-test setup into one Sol-low implementation packet rather than creating a separate agent. After setup, Luna-low may execute a settled browser journey and capture evidence; unexpected behaviour or judgment returns to Sol. Reuse any established runner and skip Playwright for backend-only, non-browser, or planning-only work.

Reasoning values are starting defaults, not quotas. Use Sol-low for settled routine work and Sol-medium for planning, review, or substantial implementation; raise Sol only for ambiguity, consequence, or a failed evidence-led attempt. Keep Luna low. Use Astra for architecture and exceptional decisions, normally at high reasoning, and never assign it production code.

## Dispatch

Inspect actual tool and model availability. Use the smallest useful agent set. The lead performs tiny discovery directly; delegate only when expected context or rework savings, or required independence, exceeds handoff overhead. This token-first rule overrides the base skill's default dispatch breadth, not its contracts, locks, or evidence gates.

Use `fork_turns: "none"` and compact self-contained packets for tier workers, planners, validators, and reviewers. Set the explicit model and starting reasoning for routed agents. Never simulate routing by naming a model in prose. If requested routing is unavailable, report the exact limitation and use only supported alternatives without claiming the requested model ran.

When task size warrants it, keep one canonical immutable brief/contract artifact at a named path. Give packets a stable prefix containing its path, snapshot, contract version, role, model, owned files, resource locks, and expected result; add only criterion-specific excerpts and checks. Send delta-only follow-ups. Validators still receive every applicable criterion and contract detail, never a summary that omits cases.

Keep implementation packets risk-homogeneous. Sol is the implementation default; match its reasoning effort to the packet rather than promoting adjacent deterministic work because one item is difficult. Split disjoint work when that lowers total cost without creating conflicting ownership. Luna is not an implementation fallback.

Workers are leaves: no recursive delegation, independent commits/branches, or competing shared builds. Keep one owner per write set. Reassess effort after contract settlement and each validation cycle. Reuse a worker only while role and model still fit. Lower Sol reasoning when remaining work becomes deterministic; use Luna only when the remaining packet is entirely non-editing and mechanical. Never run two writers against the same files. Keep raw logs local and return the compact handoff from `fullstack-delivery`.

## Escalate without restarting

Start implementation on Sol at the lowest adequate effort. Give a failed packet one evidence-led correction when the cause is understood, then raise Sol's reasoning with the reproduction and existing changes. Route architecture changes and exceptional unresolved correctness decisions to Astra, then return implementation to Sol.

Contract changes return to the Sol planner. After the same blocker survives the revised decision and one evidence-led correction, stop automatic retries and surface the missing contract, environment, or user decision while unaffected work continues.

Reuse stable installs, services, workers, and valid evidence. Batch related small work; avoid microtasks, repeated context, and unchanged checks. Preserve the base workflow's ownership, retry, resource-lock, validation, and completion rules without restating them. Do not reduce requirements, tests, UX, safety, or the selected independent-validation gate for efficiency.

Tier choice alone proves neither fewer tokens nor lower cost. Use `tokenomics-audit` only when explicitly requested or scheduled; report measured usage separately from structural proxies and never equate desktop usage with API billing.

Example: `Use $fullstack-efficient, light profile, to implement: ...`
