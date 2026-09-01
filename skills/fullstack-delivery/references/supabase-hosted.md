# Hosted Supabase delivery

Use this workflow when the app requires durable shared persistence and Supabase is selected. It provisions and updates hosted resources directly; it does not run a local database.

## Decide and inspect

- Preserve a database provider required by the brief or already used by the supplied repository.
- Inspect `supabase/config.toml`, `.vercel/project.json`, environment-variable names and existing migrations before creating anything. Reuse the intended linked resources after verifying their account and project identity.
- If there is no intended database during an authorised implementation or deployment, use the authenticated Supabase CLI organisation. With one available organisation, select it without stopping. If several are available and the target cannot be inferred, ask one concise question before creating the project.
- Default a new UK-hosted project to `eu-west-2`. Derive its name from the application. Do not create projects during planning-only work.

## Provision

Pin the stable CLI in the application with `npm install --save-dev --save-exact supabase`, then use `npx supabase`. Check installed help when flags may have changed.

Run `supabase init` to create repository configuration. This does not require Docker. Create a strong random database password inside the executing process; never print it, put it in a tool argument, commit it or send it to another agent. Use it to create and link the hosted project. Keep project ref and organisation ID as identifiers, not secrets.

```text
npx supabase orgs list --output json
npx supabase projects create <app-name> --org-id <org-id> --db-password <ephemeral-password> --region eu-west-2
npx supabase projects list --output json
npx supabase link --project-ref <project-ref> --password <ephemeral-password>
```

Avoid concurrent provisioning. The lead owns project creation, CLI linking, package changes, migrations and deployment environment configuration.

## Define and deploy schema

Create committed migrations with `supabase migration new <name>`. Keep the first data model small and derived from the requirements. For tables exposed through the Data API, enable row-level security, set least-privilege grants and add policies for the required anonymous or authenticated operations in the same migration.

Review the migration for destructive SQL. On a new empty project, apply it after a dry run. On an existing project, do not apply destructive changes without confirming they preserve intended data.

```text
npx supabase db push --dry-run
npx supabase db push
npx supabase gen types typescript --project-id <project-ref> > src/lib/database.types.ts
```

Do not use `supabase start`, local reset commands, `db reset --linked`, project deletion or secret-key reveal commands. Test through the hosted project using isolated records and clean them up through ordinary application behavior or narrowly scoped test cleanup.

## Configure the app and Vercel

Prefer the publishable-key/RLS path. The usual Next.js variables are:

```text
NEXT_PUBLIC_SUPABASE_URL=https://<project-ref>.supabase.co
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=<publishable-key>
```

Retrieve API-key metadata without `--reveal`, select the publishable key in memory and never echo the full CLI response. Do not retrieve or configure an elevated key unless the implementation genuinely requires server-side administrative access.

Verify the intended Vercel project before writing variables. Pipe values through stdin to `vercel env add` for `production,preview`; use `--force --yes` only when updating the verified intended project. Treat elevated keys as sensitive. Re-deploy after changing environment variables, because existing deployments do not receive new values.

## Evidence

Verify migration status, generated types, the app's permitted and denied data operations, persistence across refresh, and the deployed main journey. Report the Supabase project ref, region and environment-variable names. Do not report credential values.
