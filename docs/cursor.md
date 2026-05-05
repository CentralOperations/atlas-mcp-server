# Atlas MCP — Cursor

Connect Atlas to the Cursor IDE.

## 1. Get an API key

Sign in at https://www.mind-vest.io/atlas → **Dashboard** → **API Keys** → **Generate key**.

## 2. Edit Cursor's MCP config

Cursor reads MCP server configs from `~/.cursor/mcp.json` (user-scope) or `<project>/.cursor/mcp.json` (project-scope).

```json
{
  "mcpServers": {
    "atlas": {
      "url": "https://atlasmcp.finmanagerai.com/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_ATLAS_API_KEY"
      }
    }
  }
}
```

Cursor auto-detects HTTP transport from the `url` field; no `type` needed.

## 3. Restart Cursor

**Settings → MCP** should show `atlas` with a green status dot. Click it to see the discovered tools.

## 4. Test prompt

In Composer (Cmd/Ctrl-I):

> "Use Atlas to compare NVDA and AMD: quote, top-volume options today, and analyst price targets."

## Required env / inputs

| Name | Required | Notes |
|---|---|---|
| `Authorization` header | yes | `Bearer YOUR_ATLAS_API_KEY`, inline in config |

## Troubleshooting

- **`atlas` shows red in Settings → MCP.** Hover for the error message. Most common: bad JSON, wrong URL, or `Bearer` typo.
- **Tool calls succeed but show no output.** Cursor sometimes truncates large JSON. Ask the model to summarize rather than dump the raw payload.
- **`401`/`403`.** Regenerate the key.
- **`429 rate_limit`.** Free-tier cap or burst limit; wait or upgrade.

## Capabilities & permissions

- Same as every other client: server-side reads + (with explicit approval) writes for orders, triggers, and workflows. No local FS or shell access.

See [security.md](security.md) and [tools.md](tools.md).
