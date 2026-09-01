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
