# Full-stack launch prompt

Use the original brief as the source of truth. Fill factual fields and omit optional fields that do not apply.

```text
Use $fullstack-delivery to implement and deploy this app.

Profile: light [or medium / high]
Delivery mode: rapid [omit for normal scheduling]
Original brief: [paste the complete brief]
Starting repository: [current workspace or supplied repository]
Deliverables: [required code, URL, documentation and other outputs]
Stack: [required stack, or free choice]
Vercel target: [intended account/team and project, or a new project]

Extract mandatory requirements and acceptance checks. Make a concise plan
and agree a shared API contract before splitting implementation.
Use Next.js + TypeScript if no supplied stack or stronger preference applies.

Use the default two-worker parallel implementation once the scaffold and contract are ready:
- Frontend owns named screens/components/styles and consumes the contract.
- Backend owns named API/server/storage files and implements the contract.
- You own shared files, dependencies, integration, deployment, validation coordination and final evidence.
Use disjoint file ownership. All implementation, research, validation and review
agents are leaves and do not delegate.

In rapid mode, pipeline stable surfaces directly into independent validation.
Run narrow changed-surface checks first, then one full surface gate after fixes.
Reuse the lead-managed install, server, build and isolated fixtures where safe.
Assign the aggregate production build/static gate to one validator and never rerun
an identical command against an unchanged snapshot.
For UI-heavy work with four slots, split frontend into visual-foundation and
interaction workers only after defining their component contracts and disjoint files;
otherwise retain one frontend worker.

When material repository or external research is needed, send a bounded read-only
research agent to gather authoritative evidence while unaffected implementation
continues. Resolve contract, dependency, security or data-model findings before
workers implement the affected decision.

Define done through observable acceptance criteria and use test-first checks.
Use separate frontend/backend validation agents for the affected surfaces. Start
each when its implementation surface is stable and run them concurrently when their environments are independent,
then use a separate read-only reviewer of the settled code/tests.
Validators may add missing tests in assigned files but return production defects
to the implementation owner. Required failing tests must not be skipped or weakened.
Run review and audit work only inside validation or read-only review agents.
The lead uses requesting-code-review to dispatch the final reviewer; the reviewer
follows its read-only template and does not dispatch another agent.

This request authorises implementing the brief and deploying to the target above.
Deploy a runnable scaffold early. Connect the first real frontend/backend flow
early, then finish required behaviour, verification and handoff.
Return the deployed URL, checks, requirement coverage, known gaps and trade-offs.
Reserve the final critical-path window for validation, one aggregate gate, final
review, deployment and URL verification; stop optional work when it begins.
```

For planning only, use this separate prompt:

```text
Use $fullstack-delivery to refine this brief into an execution prompt, API contract
and concise implementation plan. Do not implement or deploy yet.

Profile: light [or medium / high]
Original brief: [paste the complete brief]
Starting repository: [current workspace or supplied repository]
Stack: [required stack, or free choice]
Intended deployment: Vercel

Preserve all mandatory requirements, identify consequential unknowns and define
acceptance checks. Include proposed frontend/backend ownership in the plan.
Return the plan and a suggested execution prompt for later use. Do not launch
implementation workers or run deployment commands for this planning request.
```
