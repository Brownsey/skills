# Delivery profiles

Read the shared baseline and the selected profile. Profiles describe engineering depth; they are not product templates or promises of production readiness.

## Shared baseline

- Implement the complete agreed requirements and maintain a concrete acceptance checklist.
- Reuse the supplied stack. With free choice, the baseline is Next.js App Router and TypeScript on Vercel, familiar styling, and server Route Handlers where an HTTP API helps the frontend/backend contract.
- Use a managed database when durable shared data is needed. When no provider is specified, Stephen's default is hosted Supabase through the workflow in [supabase-hosted.md](supabase-hosted.md). Preserve an intended existing provider or linked project. Do not start the local Docker stack unless he explicitly requests it.
- For Supabase, keep migrations in the repository, configure least-privilege access and row-level policies for exposed data, and test permitted and denied access. Use current official Next.js/SSR guidance for cookie-based authentication. Keep elevated secret/service-role keys server-side; publishable keys require appropriate database policies, not secrecy.
- Treat input validation, authorisation, required persistence, accessibility basics and meaningful failure handling as baseline concerns in every profile.
- Use a small set of checks tied to actual failure modes. Report results accurately. Prefer readable direct code over dense one-liners that obscure the contract.
- Add no auth screens, queues, dashboards, storage buckets or other features solely because a higher profile was selected.

## Light

Choose direct implementations and the smallest complete data model. Reuse components and installed utilities; add abstractions only when they simplify an actual requirement.

Use ordinary request/response flows. For a data-backed app, a small Supabase schema and the necessary policies/migrations can be enough. If the brief requires login, implement the real login/session/authorisation flow; do not replace it with a mock to remain light.

Verify the main journey, important validation/error cases, required persistence and deployment. Keep the handoff to setup, results, limitations and a short explanation of the architecture.

## Medium

Use explicit boundaries for recurring business operations and reusable UI patterns across the required workflows. Record the data model and API contract so both workers share the same assumptions.

When Supabase is the selected provider and the brief needs them, use Supabase Auth for identities, database policies for ownership/roles and Storage for files. Otherwise use the selected provider's equivalents. Include migrations and useful seed data; verify each role's allowed and denied operations. Paginate lists or coordinate multi-step writes when the expected data and behaviour require it.

Add integration checks across backend and frontend boundaries and cover meaningful failure states. Document important trade-offs, environment setup and how to reproduce checks. Keep provider components limited to what the app actually uses.

## High

Identify concrete reliability, security, scale and operational requirements before choosing architecture. Briefly document consequential alternatives and the selected approach. Use additional services only where those requirements justify them.

For required integrations and state changes, consider consistency boundaries, idempotency, retries and recovery. For tenant-aware apps, demonstrate tenant isolation. For uploads or jobs, define access and failure handling. Supabase Auth, Postgres, Storage or Realtime may satisfy particular requirements; a high profile does not imply using all of them.

Verify the stated risks through targeted integration/end-to-end checks and, when needed, concurrency/load or failure-path checks. Provide operational guidance for configuration, migrations, observability and recovery relevant to the app. Distinguish what was tested from remaining assumptions; do not claim production readiness based on the profile label.

## Provider references

Consult these only when the selected implementation uses Supabase:

- [Next.js quickstart](https://supabase.com/docs/guides/getting-started/quickstarts/nextjs)
- [Server-side authentication](https://supabase.com/docs/guides/auth/server-side/nextjs)
- [Row-level security](https://supabase.com/docs/guides/database/postgres/row-level-security)
