---
name: tokenomics-audit
description: Audit model, token, tool, elapsed-time, rework, and validation efficiency for an agent workflow. Use only when explicitly requested or for an explicitly scheduled periodic audit, not as a routine delivery step.
---

# Tokenomics audit

Audit cost per accepted outcome without weakening requirements, tests, review, safety, or quality. Do not invoke this skill during ordinary delivery unless the user explicitly requests an audit or an existing schedule calls for one.

## Establish the unit

Choose the smallest meaningful denominator: accepted criterion, completed task, or delivered change. Record scope, period, workflow/profile, environment, and what counts as accepted. Compare like-for-like work only; difficulty, tool availability, and validation depth can dominate model choice.

## Collect measurements

When the runtime exposes them, record per pass and in total:

- model and reasoning effort;
- input, cached-input, output, and reasoning tokens;
- tool calls and failed/retried calls;
- elapsed and active time;
- implementation, validation, review, and rework passes;
- accepted criteria or tasks completed.

Distinguish measured values from estimates. Do not infer hidden reasoning tokens, prices, cache hits, or billing. Desktop usage, API tokens, subscription limits, credits, and provider invoices are different accounting systems; never claim they are equivalent without authoritative measured conversion data.

If usage data is unavailable, use structural proxies and label them as proxies: repeated brief or repository context, duplicated tool output, avoidable full-history forks, repeated unchanged checks, agent count and handoffs, unnecessary model escalation, preventable retries, and time to accepted result. Structural proxies indicate likely waste, not monetary cost.

## Evaluate

Calculate available ratios such as tokens, tool calls, elapsed time, and rework passes per accepted criterion or task. Separate first-pass delivery from defect correction. Identify:

- repeated context that should be referenced once or narrowed per packet;
- duplicate checks against an unchanged snapshot;
- needless agents, microtasks, or handoffs whose coordination exceeds useful parallelism;
- poor cacheability caused by unstable prefixes, oversized prompts, or repeated changing context;
- lower-tier work that escalated without evidence, or high-risk work under-routed and later reworked;
- long raw outputs that could remain in worker context while concise evidence is returned.

Do not optimize raw token count in isolation. Prefer the lowest cost per accepted criterion or completed task, including rework and independent validation. A shorter failed pass is not more efficient than a slightly larger accepted one.

## Recommend

Return a compact audit with scope, measured data, unavailable fields, proxies, ratios, largest waste sources, and prioritized changes. Each recommendation must name expected benefit, quality/safety constraint, and a future measurement that could confirm it. Favor narrow changes: remove duplicate context, batch related work, reuse valid evidence, stabilize prompts for caching, use fewer agents when work is coupled, and route models by uncertainty and consequence.

Never recommend skipping required cases, reducing independent validation below the applicable risk gate, concealing missing evidence, or replacing correctness with a cheaper model. If data cannot support a cost conclusion, say so and recommend instrumentation rather than asserting savings.
