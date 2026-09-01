# Command-line tools

`tools.json` records programs and setup guidance. Binaries and account credentials stay on each device. Run `../setup/check-tools.ps1` to check command availability.

## GitHub CLI

Use Git for commits/push/pull and GitHub CLI for repository, issue, pull request and workflow operations. Install on Windows:

```powershell
winget install --id GitHub.cli -e --source winget
```

Open a fresh terminal if `gh` is not yet on PATH. Authenticate and verify on each device:

```powershell
gh auth login --hostname github.com --git-protocol https --web
gh auth status
```

Complete the account consent yourself. Keep credentials outside the repository and chat. Existing Git Credential Manager authentication for `git push` does not imply `gh` is authenticated. Avoid changing an already-working Git credential helper merely to enable `gh`.

Example read-only commands:

```powershell
gh repo view Brownsey/skills
gh pr list --repo Brownsey/skills
gh run list --repo Brownsey/skills --limit 5
```

See the [official installation instructions](https://github.com/cli/cli#installation) and [authentication manual](https://cli.github.com/manual/gh_auth_login).

## Vercel CLI

Optional alongside Vercel MCP, particularly for deploying a local working tree. Follow the [official CLI installation and login instructions](https://vercel.com/docs/cli). Authenticate separately from MCP; do not commit local `.vercel` state or credentials into this library.

## Supabase CLI

Use the CLI against hosted Supabase projects. Docker is not part of this workflow. It requires Node.js 20 or later. Pin the CLI in each application so its lockfile makes the command reproducible:

```powershell
npm install --save-dev --save-exact supabase
npx supabase login
npx supabase orgs list --output json
```

`supabase login` stores account credentials outside the repository. Never commit access tokens, database passwords, secret keys or generated environment files.

Create and link a hosted project after the application name, organization and region are known:

```powershell
npx supabase init
npx supabase projects create <app-name> --org-id <organization-id> --db-password <database-password> --region eu-west-2
npx supabase projects list --output json
npx supabase link --project-ref <project-ref>
```

Keep schema changes in committed migrations and apply them directly to the linked hosted database:

```powershell
npx supabase migration new initial_schema
npx supabase db push --dry-run
npx supabase db push
npx supabase gen types typescript --project-id <project-ref> > src/lib/database.types.ts
```

Use `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` for browser access with least-privilege grants and row-level security. Add a secret key only for required server-side administrative operations; never expose it to browser code. Configure deployment values through Vercel environment-variable commands or its dashboard rather than committing them.

The shared `fullstack-delivery` workflow automatically selects hosted Supabase when an authorised app implementation needs durable persistence and no provider was specified. It reuses intended existing resources, creates a new hosted project when needed, applies migrations, generates types and configures the verified Vercel project. Planning-only work remains read-only.

Do not run `supabase start`, `db reset --local` or other local-stack commands in this remote-only workflow. See the [official Supabase CLI guide](https://supabase.com/docs/guides/local-development/cli/getting-started), [project-management reference](https://supabase.com/docs/reference/cli/supabase-start) and [migration workflow](https://supabase.com/docs/guides/local-development/cli-workflows).
