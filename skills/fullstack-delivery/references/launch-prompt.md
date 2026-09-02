# Full-stack launch prompt

The skill owns the workflow. Keep the launch prompt factual and lean; fill known fields and omit optional ones that do not apply.

```text
Use $fullstack-delivery to interrogate, implement, validate and deploy this app.

Profile: light [or medium / high]
Delivery mode: rapid [or normal]
Delivery deadline or constraint: [time/date/none]
Original brief: [complete brief]
Starting repository: [workspace/repository]
Deliverables: [code, URL, documentation and other required outputs]
Stack: [required stack or free choice]
Deployment target: [Vercel account/team/project or new project]

Inspect the brief, repository and environment first. Parallelise distinct repo,
technical-risk and UI-reference intake evidence, await relevant findings, then ask
at most one compact batch of questions only for unresolved decisions that block
correct work or materially change the contract. Publish the canonical kickoff packet
and show me the priorities, optional cut order and dependency-driven worker split.

This request authorises in-scope implementation and deployment to the target above. Follow the
skill's selected scheduling, testing, independent validation, review and URL-verification
rules. Treat my later input as steering through the lead. Return the verified URL,
requirement evidence, checks, known gaps and material trade-offs.
```

For planning only:

```text
Use $fullstack-delivery to interrogate this brief and return its canonical kickoff
packet plus a reusable execution prompt. Do not implement, provision or deploy.

Profile: light [or medium / high]
Delivery mode: rapid [or normal]
Original brief: [complete brief]
Starting repository: [workspace/repository]
Stack: [required stack or free choice]
Intended deployment: [target]

Inspect available evidence before asking at most one compact batch of blocking
questions. Preserve mandatory requirements with stable IDs, acceptance evidence,
assumptions, priorities, optional cut order, API/UI contracts, resource locks and
dependency-driven ownership.
```
