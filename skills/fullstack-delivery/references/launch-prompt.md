# Full-stack launch prompt

The skill owns the workflow. Keep the launch prompt factual and lean; fill known fields and omit optional ones that do not apply.

```text
Use $fullstack-delivery to interrogate, implement, validate and deploy this app.

Profile: light [or medium / high]
Delivery mode: normal [or rapid / time-boxed]
Delivery deadline or constraint: [time/date/none]
Original brief: [complete brief]
Starting repository: [workspace/repository]
Deliverables: [code, URL, documentation and other required outputs]
Stack: [required stack or free choice]
Deployment target: [Vercel account/team/project or new project]

Inspect the brief, repository and environment first. Optimise for minimum wall-clock
delivery time: parallelise bounded discovery, preflight and ready implementation behind
stable contracts; use effective free capacity; refill it as packets complete; pipeline
independent validation as surfaces stabilise. Await only contract-affecting evidence.
Ask at most one compact batch of questions only for unresolved decisions that block
correct work or materially change the contract. Publish the canonical kickoff packet
with priorities, optional cut order, dependency DAG, ownership, named resource locks
and the risk-based independent-validation gate. For rapid or time-boxed delivery, set
a validation reserve from observed durations or repository history and the point where
optional work stops. If neither exists, label a conservative estimate and revise it
after the first measured gates.

This request authorises in-scope implementation and deployment to the target above. Follow the
skill's testing, independent validation, review and URL-verification rules. Treat my
later input as steering through the lead. Return the verified URL,
requirement evidence, checks, known gaps and material trade-offs.
```

For planning only:

```text
Use $fullstack-delivery to interrogate this brief and return its canonical kickoff
packet plus a reusable execution prompt. Do not implement, provision or deploy.

Profile: light [or medium / high]
Delivery mode: normal [or rapid / time-boxed]
Original brief: [complete brief]
Starting repository: [workspace/repository]
Stack: [required stack or free choice]
Intended deployment: [target]

Inspect available evidence before asking at most one compact batch of blocking
questions. Preserve mandatory requirements with stable IDs, acceptance evidence,
assumptions, priorities, optional cut order, API/UI contracts, dependency DAG, stable
contract boundaries, named resource locks, capacity-aware ownership, and the proposed
validation risk/gate. For rapid or time-boxed delivery, include an observed-duration
or repository-history validation reserve and optional-work cut boundary. If neither
exists, label a conservative estimate for revision after the first measured gates.
```
