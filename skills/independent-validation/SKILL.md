---
name: independent-validation
description: Choose and run proportionate independent validation and code review for implementation work. Use when planning or completing code changes that need a risk-based validation gate; trivial documentation, configuration, and reversible changes may remain with the lead.
---

# Independent validation

Match independence to change risk. Validate observable requirements, not the implementer's confidence. Preserve repository tooling and use `verification-before-completion` for the final evidence check.

## Choose the gate

Classify the whole change at its highest applicable risk. Record the reason; do not split a coupled risky change into lower-risk labels.

| Risk | Typical change | Required gate |
| --- | --- | --- |
| Trivial | Documentation, non-behavioural configuration, formatting, or a readily reversible edit with no runtime effect | Lead runs the smallest targeted check. No independent agent required. |
| Ordinary substantive | One application surface, bounded behaviour, established patterns, no sensitive boundary or irreversible data effect | One implementation owner, then one independent combined validation and review pass. |
| High | Multiple coupled surfaces; authentication, authorization, persistence, security, migrations, or external integrations; difficult rollback; a materially reworked solution; or any change that has failed validation | Separate validator(s) for affected surfaces, then a distinct final read-only reviewer after fixes settle. |

Escalate whenever uncertainty or consequence exceeds the selected row. Unavailable agents do not lower the gate: run useful local checks, state which independent evidence is missing, and do not claim it passed.

## Prepare evidence

Define stable acceptance criteria before implementation. Include success, relevant failure and permission cases, persistence, user-visible states, and the check that proves each criterion. For behaviour changes, use `test-driven-development`; add a regression test before fixing an existing defect when practical.

Give each validator a compact packet:

- role and risk classification;
- original requirements and criterion IDs;
- contract or expected behaviour independent of the implementation;
- repository, base and tested revision or working-tree snapshot;
- changed and relevant files, including uncommitted scope;
- commands, environment, services, test-data namespace, and shared-resource locks;
- applicable review guidance and known limitations;
- expected output: criterion result, command and exit result, artifacts, findings, skips, and snapshot.

Use this handoff schema and omit empty fields: `STATE`, `FILES`, `CRITERIA`, `CHECKS`, `FINDINGS`, `RUNTIME`, `ASSUMPTIONS`. Keep raw logs with the worker; return decisive evidence and exact reproductions.

## Run the gate

Validators must not have authored the production code they assess. In the ordinary combined pass, one independent agent may execute relevant checks, inspect the diff and tests, and report requirement or code defects; do not dispatch an additional reviewer. For high-risk work, use distinct affected-surface validators and a final reviewer who did not author production code or tests. Combine compatible UI, accessibility, performance, security, and architecture checks by surface; do not add one agent per skill.

Validators may add missing tests only within assigned test files. They do not change production code or acceptance criteria. Return production defects to the implementation owner with severity, failed criterion, reproduction, expected and observed results, and file/state. Correct a faulty test only with an explicit rationale. After a rework or failed pass, retain the high-risk gate.

Where frontend and backend form the deliverable, prove at least one relevant integrated journey through the real backend and required persistence using isolated non-production data. Mocked suites alone cannot prove schema, policy, migration, adapter, or cross-surface behaviour. Required cases cannot be skipped, quarantined, filtered out, weakened, or snapshot-refreshed into a pass.

For new UI or a material redesign, capture an early desktop/mobile view once the main journey renders so major direction errors can be corrected. Final frontend validation still inspects the running result at relevant desktop/mobile sizes, interaction states, keyboard/accessibility behaviour, and the agreed visual direction. Small changes within an established design do not require an early screenshot ritual.

## Protect sensitive changes

- Authentication and authorization checks must include negative and cross-actor cases at the real enforcement boundary.
- Security-sensitive work requires a dedicated security-aware validation scope; never expose credentials or weaken controls to make tests pass.
- Validate migrations against an isolated or approved target, inspect the plan or dry run first when supported, preserve rollback/recovery expectations, and never reset or destructively change a linked database without explicit authorization.
- External integrations need contract/error-path evidence and a controlled real-adapter check when the requirement depends on that integration. Do not use production resources merely for convenience.

## Reuse and invalidate evidence

Evidence remains valid only for its recorded files, dependencies, contract, environment, data assumptions, and snapshot. Reuse unchanged passing evidence; do not rerun checks for ceremony. Code, test, dependency, contract, migration, configuration, environment, or material data changes invalidate only affected evidence. A Critical or Important finding invalidates related validation and deployment evidence until fixed and rechecked.

After fixes, the same validator reruns failed and dependent checks; unaffected evidence may remain. If the same blocking failure returns twice, reassess the contract, environment, ownership, and root cause before another cycle.

For high-risk work, dispatch the final reviewer after implementation and validation fixes settle. Use `requesting-code-review` with the original requirements, actual base and final scope, valid check evidence, and prior findings. The reviewer inspects requirement coverage, test quality, sensitive boundaries, and diff defects without duplicating unchanged passing suites. Resolve Critical and Important findings before completion.
