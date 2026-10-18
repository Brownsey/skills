---
name: fullstack-efficient
description: "Token-first full-stack delivery with Sol 6.1 doing all code work in the main chat and only Luna subagents for reading/research. Use when requested by name or when an app brief asks for token-efficient delivery."
---

# Full-stack efficient

Use [fullstack-delivery](../fullstack-delivery/SKILL.md) for profiles, contracts, implementation depth, resource safety, persistence, and delivery requirements. Apply [efficiency-implementation](../efficiency-implementation/SKILL.md) for model routing and execution: Sol 6.1 performs all planning, architecture, implementation, tests, validation, and review in the main chat. Only Luna reading/research packets may use subagents.

This overlay replaces the base skill's time-first dispatch breadth with a token-first objective: minimise total tokens or credits per accepted criterion or completed task, including checks and rework. It also replaces the base skill's implementation/validation/reviewer dispatch and default agent-independence requirements with the main-chat policy. Do not create Sol/Astra workers, separate implementation tasks, or another chat as a workaround. Keep risk-specific evidence and report self-review truthfully; an externally mandated independent sign-off remains missing until actually supplied.

## Research and context

Batch related reading, repository discovery, documentation research, and source summaries into compact Luna packets. Follow the source, version, trust, secret-exclusion, and handoff rules in `efficiency-implementation`. Luna does not edit code/configuration, run implementation or validation checks, judge correctness, or delegate further. The main agent reads governing instructions and directly inspects source, diffs, and tests integral to its decisions.

Keep one canonical brief and plan. When task size warrants it, give reader packets a named brief/contract path, snapshot, relevant questions, source boundaries, and expected sourced findings. Pass necessary excerpts rather than full conversation history; send delta-only follow-ups and keep raw logs local. Do not create a reader for every file access.

If Luna is unavailable, disclose that route and do necessary permitted reading in the main chat. If the main model differs from Sol 6.1, disclose the mismatch; do not spawn Sol to replace main-chat execution. Explicit later user choices and runtime restrictions win.

## Main-chat implementation and verification

Use the lowest adequate main-agent reasoning for settled work; raise it for ambiguity, consequence, or an evidence-led failed attempt. All implementation, test authoring, check execution, integration, and review stay in this chat, including complex or high-risk work. Continue independent main-chat work while Luna reads, but wait for evidence before decisions that depend on it.

Retain the base skill's eligible Playwright setup, established test runner, real-backend journey, persistence safeguards, and deployment boundaries. The main agent owns setup, installation, tests, browser interaction, and validation. Do not add full-stack setup or a browser runner to unrelated, backend-only, or planning-only work.

Use `independent-validation` for risk classification and required evidence, with the main-chat exception in `efficiency-implementation`. After checks, perform a separate self-review against the original criteria, source, and tests. Never call that independent validation or review. Preserve security, negative permission cases, migration/recovery checks, and any explicit external sign-off gap. Use `verification-before-completion` before claims.

Keep one writer and serialise conflicting installs, builds, migrations, or shared test state. Reuse stable services, settled decisions, and valid evidence. Rerun failed or affected checks after changes; avoid repeated unchanged suites. After repeated failure, reassess the reproduction, contract, environment, and root cause before retrying in this chat.

Do not reduce requested behaviour, tests, UX, accessibility, or safety for efficiency. Keep measured tokens, desktop credits, and API billing separate. When usage is unavailable, label structural proxies rather than claiming savings. Use `tokenomics-audit` only when explicitly requested or scheduled.

Example: `Use $fullstack-efficient, light profile, to implement: ...`
