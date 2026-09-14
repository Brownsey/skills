---
name: fullstack-efficient
description: Deliver full-stack apps through subagents with Terra routine implementation, Sol substantial implementation, and Astra planning, hardest implementation and independent code review. Use when requested by name or when an app brief asks for tiered models or token-efficient delivery. Planning-only requests stop at the plan.
---

# Full-stack efficient

Use [fullstack-delivery](../fullstack-delivery/SKILL.md) as the delivery workflow; read it once and load only references needed for the current task. This skill supplies model routing, not a second planning process. Retain its light/medium/high profiles (default light), design guidance, TDD, independent validation, hosted Supabase and Vercel gates. Apply the scoped routing exceptions in the shared AGENTS.md. Ordinary app briefs continue to use the base skill unless efficient delivery is selected.

## Model routing

Use these exact model IDs when the runtime supports them. These are workflow choices, not pricing or token-saving guarantees.

| Work | Model | Default reasoning |
| --- | --- | --- |
| Brief interrogation, acceptance criteria, API/UI contracts, architecture, decomposition and consequential replanning | `gpt-6-astra` | high |
| Routine implementation, straightforward regression tests, scaffold/config edits, bounded research and mechanical check execution | `gpt-5.6-terra` | medium |
| Substantial implementation and test authoring with clear contracts and familiar patterns | `gpt-5.6-sol` | high |
| Hardest implementation and test problems with high uncertainty or subtle correctness requirements | `gpt-6-astra` | high |
| Code reviews and code-based security, architecture, UI or performance audits; settled final review | `gpt-6-astra` | high |

Route by uncertainty and consequences, not file count or frontend/backend labels. Terra handles existing patterns, simple forms, direct CRUD and deterministic fixes behind stable contracts. Sol handles substantial multi-step features, familiar integrations and complex state flows with well-understood contracts. Astra handles difficult concurrency or transactional guarantees, subtle authorization/RLS boundaries, unfamiliar cross-system failures and problems requiring significant new reasoning. Simple use of an established authentication adapter does not automatically require Astra. Send obviously hard work directly to Astra; lower-tier failures are not prerequisites. Split routine work out of complex packets only when ownership and contracts stay clear. UI work still requires the base design and accessibility standards.

## Dispatch and coordination

- The current lead coordinates user communication, scheduling, file/resource locks and evidence. Delegate substantive planning to an Astra leaf even if the lead is already Astra; keep one canonical plan instead of writing it twice. The skill does not change the lead's model.
- Inspect actual spawn-tool support and available model IDs before dispatch. With `collaboration.spawn_agent`, set `model`, `reasoning_effort` and `fork_turns: "none"` explicitly. Omitted or `"all"` history inherits the lead model and cannot be combined with these overrides. Pass a compact, self-contained packet instead. Never simulate model selection by merely naming a model in the prompt.
- A packet contains the task, role/model, original relevant requirements, repository and source paths, contract version, owned files, prohibited shared resources, checks and expected result. Every worker is a leaf: no recursive delegation, independent commits, branches or shared builds.
- Reuse an existing worker for related follow-ups only when its model and role still fit. `followup_task` does not change models. For a tier change, stop the old writer, collect its diff and failure evidence, then transfer exclusive ownership to a new worker; never run both against the same files.
- If a requested model or model-selection tool is unavailable, report the precise limitation and continue independent work with supported requested models. Do not silently substitute an inherited model or claim the requested routing ran. Ask for an alternative only when missing capability blocks further work.
- Use effective runtime capacity, normalized to subagent slots: a total-agent limit includes the lead, while `agents.max_concurrent_threads_per_session` counts subagents. Account for occupied slots and dispatch `min(free slots, ready useful packets)`; a lower runtime limit wins over local configuration. Refill after handoffs, reuse or release completed agents as supported, and stop dispatch attempts at the first capacity refusal until capacity is released. Never fork peer tasks to expand capacity.

## Delivery sequence

1. Give the Astra planner the original brief and relevant repository evidence. It returns one compact plan with acceptance criteria, consequential questions, API/UI contracts, dependency order, exact ownership, model choice per packet and validation commands. Bounded Terra research can gather independent facts while planning proceeds; settle affected unknowns before implementation. Planning-only requests end with this plan, without code edits or provisioning.
2. Dispatch ready Terra, Sol or Astra implementation packets from that plan. Use a separate Astra implementation worker rather than repurposing the planner. The lead controls shared files and resources but delegates their actual code edits to one named worker at a time, including scaffold, dependencies and integration. No agent owns a whole directory when that overlaps another packet. Require focused failing/passing checks for behavior changes.
3. Start independent frontend/backend validation when each surface stabilizes. Terra executes established checks and captures browser journeys/screenshots; route missing-test authoring to Terra, Sol or Astra using the same complexity criteria. Validators must be distinct from all production implementation authors; test authors cannot be the final reviewer. Send judgment-based code audits to Astra agents that did not author the audited code or tests; reuse a single Astra surface auditor for compatible audits instead of adding an agent per skill. Preserve required browser, accessibility, integration and real-backend evidence.
4. Use a fresh read-only Astra reviewer for the settled combined diff and tests, distinct from the planner, implementers and test authors. Follow `requesting-code-review`; provide the original requirements, actual base plus uncommitted scope, check evidence and prior audit findings. It inspects code and test quality rather than repeating unchanged passing suites. Fix Critical/Important findings with the routed implementation owner, then rerun affected validation and return the delta to the same reviewer.
5. Coordinate requested deployment through a Terra worker for the established path, Sol for substantial troubleshooting with a known cause, or Astra for the hardest unresolved integration failures. Preserve the base workflow's authorization, migration, snapshot and URL-verification rules. Compile existing valid evidence with `verification-before-completion`; report missing gates honestly.

## Escalation and efficiency

- Start each packet on the tier justified by its known difficulty. For a Terra or Sol blocker, allow one evidence-led correction when the cause is understood; if the same blocker persists or reveals harder behavior, transfer it to Sol or Astra as appropriate with existing work and a reproduction. Terra may escalate directly to Astra. Do not restart discovery or discard working code.
- Contract or architecture changes return to the existing Astra planner; the appropriate implementation worker applies the revised decision. Escalation keeps exclusive file ownership and separate review. If the same blocker persists after an Astra worker's evidence-led correction, stop automatic retries, report the blocker and resolve the missing contract, environment or user decision while unaffected work continues.
- Keep the plan and raw brief accessible by path; send workers only their relevant material. Retain raw logs in worker context and return snapshot, changed/tested files, criterion results, commands/exit codes, decisive findings and blockers. Do not truncate safety constraints or acceptance criteria to hit a token target.
- Batch small related changes under one owner. Fill useful capacity without fragmenting coupled work into microtasks. Reuse stable installs, servers and passing evidence; rerun only checks invalidated by code, contract, dependency or environment changes.
- Do not reduce tests, review coverage, UX quality or required behavior for efficiency. When usage is exposed, distinguish token counts from cost/credits and report measured usage only; lower-tier routing alone proves neither fewer tokens nor lower total cost.

Example invocation: `Use $fullstack-efficient, light profile, to implement this brief: ...`
