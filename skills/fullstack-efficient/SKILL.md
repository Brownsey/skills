---
name: fullstack-efficient
description: "Apply a token-first model, context, and dispatch overlay to full-stack delivery: Luna mechanical discovery, the current chat model for planning and judgment, Terra routine work, Sol substantial work, and Astra exceptional decisions. Use when requested by name or when an app brief asks for tiered models or token-efficient delivery."
---

# Full-stack efficient

Use [fullstack-delivery](../fullstack-delivery/SKILL.md) for the delivery workflow. This skill is a model, context, and dispatch overlay. It explicitly replaces the base skill's time-first dispatch breadth with a token-first objective: minimise total measured tokens or credits per accepted criterion or completed task, including required validation and rework. Keep token counts, desktop credits, and API billing separate. When usage is unavailable, use labelled structural proxies rather than claiming savings. Retain the selected profile, contracts, resource safety, `independent-validation` risk gate, persistence safeguards, and definition of done.

## Route work

| Work | Model | Default reasoning |
| --- | --- | --- |
| Narrow read-only mechanical discovery: file inventory, grep, symbol/config lookup, exact extraction | `gpt-5.6-luna` | low |
| Brief interrogation, acceptance criteria, contracts, decomposition, architecture, consequential replanning | Current chat model | Current chat reasoning |
| Routine implementation, direct CRUD/forms, deterministic fixes, scaffold/config changes, established mechanical validation | `gpt-5.6-terra` | low |
| Substantial implementation and tests: complex state, concurrency, transactions, authorization-sensitive work | `gpt-5.6-sol` | medium |
| Exceptional unresolved architecture, cross-system trade-offs, or correctness decisions | `gpt-6-astra` | high |
| Judgment-based validation, specialty audits, and final review | Current chat model | Current chat reasoning |

Route by uncertainty and consequence, not file count or frontend/backend labels.

- Luna returns paths, locations, counts, or copied facts. It does not edit, interpret ambiguity, judge correctness, or choose architecture. Transfer interpretive work to Terra or the current-model planner.
- Terra owns routine work and established mechanical validation behind stable contracts. Sol owns substantial or difficult implementation after consequential decisions are settled.
- Astra decides exceptional unresolved architecture or correctness questions. It returns a decision, contract, or guidance for Sol; it does not own production code.
- Current chat model with current reasoning owns the canonical plan and judgment-based validation/review, preserving the user's selected model and effort. Do not create competing plans.

Reasoning values are starting defaults, not quotas. Use evidence to lower effort when work is deterministic. Start Terra at low and Sol at medium; escalate only for ambiguity, consequence, or a failed evidence-led attempt. Keep Astra at high for exceptional decisions only and never assign it production code.

## Dispatch

Inspect actual tool and model availability. Use the smallest useful agent set. The lead performs tiny discovery directly; delegate only when expected context or rework savings, or required independence, exceeds handoff overhead. This token-first rule overrides the base skill's default dispatch breadth, not its contracts, locks, or evidence gates.

Use `fork_turns: "none"` and compact self-contained packets for tier workers, planners, validators, and reviewers. Set explicit model and starting reasoning for tier-routed agents. Current-model planners and judgment reviewers omit model and reasoning so they inherit the current chat settings. Never simulate routing by naming a model in prose. If requested routing is unavailable, report the exact limitation and use only supported alternatives without claiming the requested model ran.

When task size warrants it, keep one canonical immutable brief/contract artifact at a named path. Give packets a stable prefix containing its path, snapshot, contract version, role, model, owned files, resource locks, and expected result; add only criterion-specific excerpts and checks. Send delta-only follow-ups. Validators still receive every applicable criterion and contract detail, never a summary that omits cases.

Keep implementation packets risk-homogeneous. Terra is the default once contracts are settled. Use Sol only when the packet itself requires substantial reasoning about complex state, concurrency, transactions, or authorization-sensitive behaviour; record that reason in the packet. Do not let one difficult item promote adjacent deterministic work. Split disjoint work when that lowers total cost without creating conflicting ownership.

Workers are leaves: no recursive delegation, independent commits/branches, or competing shared builds. Keep one owner per write set. Reassess tier after contract settlement and each validation cycle. Reuse a worker only while role and model still fit. Transfer exclusive ownership from Sol to Terra when the remaining work becomes deterministic; file ownership or handoff convenience alone does not justify retaining Sol. Never run two writers against the same files. Keep raw logs local and return the compact handoff from `fullstack-delivery`.

## Escalate without restarting

Start implementation on Terra or Sol according to known difficulty. Give a Terra failure one evidence-led correction when the cause is understood, then transfer genuinely difficult work to Sol with the reproduction and existing changes. If Sol is blocked by an exceptional unresolved architecture or correctness decision, ask Astra for that decision and return implementation to Sol.

Contract changes return to the current-model planner. After the same blocker survives the revised decision and one evidence-led correction, stop automatic retries and surface the missing contract, environment, or user decision while unaffected work continues.

Reuse stable installs, services, workers, and valid evidence. Batch related small work; avoid microtasks, repeated context, and unchanged checks. Preserve the base workflow's ownership, retry, resource-lock, validation, and completion rules without restating them. Do not reduce requirements, tests, UX, safety, or the selected independent-validation gate for efficiency.

Tier choice alone proves neither fewer tokens nor lower cost. Use `tokenomics-audit` only when explicitly requested or scheduled; report measured usage separately from structural proxies and never equate desktop usage with API billing.

Example: `Use $fullstack-efficient, light profile, to implement: ...`
