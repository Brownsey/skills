# MCP server definitions

`servers.toml` is the shared source for selected MCP definitions. It starts empty because no specific servers have been requested yet. Merely placing this file in Git does not enable a server in Codex.

For each selected server:

1. Read the provider's current documentation and add its command or URL and relevant options under `[mcp_servers.<name>]` in `servers.toml`.
2. Record any required runtime in `../cli/tools.json`, preferably pinning server package versions where supported.
3. On each device, merge the selected server's table into the local Codex `config.toml`. Back up that file first, preserve unrelated settings, and update an existing table rather than appending a duplicate. The default location is `~/.codex/config.toml`; respect CODEX_HOME if set.
4. Alternatively, use `codex mcp add` with that definition's command or URL. Check `codex mcp add --help` for options supported by the installed version. Keep the shared definition in sync with the intended local configuration.
5. Authenticate separately on each device. For OAuth servers, use `codex mcp login <name>`. For bearer tokens, use `bearer_token_env_var` to reference a locally configured environment variable. For local process servers, `env_vars` can forward selected local environment variables.
6. Restart Codex as needed and inspect the server's connection status. Git sync alone does not establish a working MCP connection.

Do not commit token values, authentication caches, private URLs containing secrets, or an entire local Codex config. Leave device-specific absolute paths local. Changing server definitions is a separate step from authorising any external actions its tools can perform.

If we later build our own MCP server, its source code can live under `mcp/<server-name>/`, with its own dependency lockfile and README. Installed dependencies and binaries stay out of Git.

[Official Codex MCP configuration documentation](https://learn.chatgpt.com/docs/extend/mcp)
