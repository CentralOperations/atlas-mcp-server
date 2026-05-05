# Atlas MCP — Claude Code

Connect Atlas to Anthropic's Claude Code CLI.

## 1. Get an API key

Sign in at https://www.mind-vest.io/atlas → **Dashboard** → **API Keys** → **Generate key**.

## 2. Install command (one-liner)

```bash
claude mcp add --transport http atlas https://atlasmcp.finmanagerai.com/mcp \
  --header "Authorization: Bearer YOUR_ATLAS_API_KEY"
```

This writes to `~/.claude.json` (user-scope) by default. To scope to the current project instead, add `--scope project` (writes to `./.claude/settings.local.json`).

### Or edit config by hand

```json
{
  "mcpServers": {
    "atlas": {
      "type": "http",
      "url": "https://atlasmcp.finmanagerai.com/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_ATLAS_API_KEY"
      }
    }
  }
}
```

## 3. Verify

```bash
claude mcp list
```

Expect `atlas` to appear with status `connected`. Inside a `claude` session, `/mcp` lists the tools Atlas exposes.

## 4. Test prompt

> "Use Atlas to fetch an SPY quote and the top 5 SPY options contracts by volume."

Claude Code should call `Stock-Quote` and `Top-Volume-and-OI-Contracts`.

## Required env / inputs

| Name | Required | Notes |
|---|---|---|
| `Authorization` header | yes | Stored inline in the config; not an env var |

You can also set `ATLAS_API_KEY` in your shell and reference it in the header value if your shell does substitution before `claude` reads it — but the simplest path is pasting directly.

## Troubleshooting

- **`claude mcp list` shows `failed`.** Run `claude mcp get atlas` to inspect the config; check for typos in URL or `Bearer ` prefix.
- **Permission prompt loops.** Approve Atlas tools once for the session, or add `mcp__atlas__*` to `permissions.allow` in `settings.json` (see [Claude Code docs on permissions](https://docs.anthropic.com/claude/docs/claude-code)).
- **`401`/`403`.** Bad key. Regenerate from the dashboard.
- **`429 rate_limit`.** Wait or upgrade plan.

## Capabilities & permissions

- All Atlas tools surface as `mcp__atlas__<Tool-Name>`. Read-only tools can run unattended; mutating tools (`Place-Order`, `Workflow-Run`, `*-Trading-Trigger`) should require user confirmation.
- No local FS access, no shell execution from Atlas's side.

See [tools.md](tools.md) for which tools mutate state.
