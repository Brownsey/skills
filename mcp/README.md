# MCP servers

The selected setup is Vercel MCP plus GitHub CLI. Git handles commits and sync; `gh` handles GitHub repositories, pull requests, issues and checks. A GitHub MCP server is not required for that workflow.

`servers.toml` records the official Vercel remote server. Placing the file in Git does not activate it. On each device, inspect any existing entry first:

```powershell
codex mcp get vercel
```

If absent, add it:

```powershell
codex mcp add vercel --url https://mcp.vercel.com
```

Complete browser consent. If authorization is still needed, run `codex mcp login vercel`. Check `codex mcp list` and connection status in Codex; restart Codex if needed. A configured entry alone is not proof that authenticated tools work.

Alternatively, back up local Codex `config.toml` and merge the table from `servers.toml`, preserving unrelated settings and avoiding duplicate entries. Respect CODEX_HOME when set. Authentication caches and tokens stay local to each device.

Vercel MCP provides project/deployment information, logs and documentation access. Vercel CLI remains useful for deploying a local working tree; its login is separate from MCP. Configuration and login do not authorize unrelated external changes.

See [Vercel MCP setup](https://vercel.com/docs/agent-resources/vercel-mcp), [Codex MCP configuration](https://learn.chatgpt.com/docs/extend/mcp) and [GitHub CLI setup](../cli/README.md).
