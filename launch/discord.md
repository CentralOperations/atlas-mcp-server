# Discord — short-form announcements

Atlas-friendly Discord servers to post in (in #show-and-tell, #share-your-projects, #showcase, or whatever the equivalent channel is — never a general chat unless explicitly invited):

- **MCP / Anthropic developer Discords** — Anthropic's MCP community Discord, the Claude Code Discord
- **Algo-trading / quant Discords** — QuantConnect, Alpaca community, Tradier developer
- **AI dev Discords** — Cursor, Cline, Continue, Codex CLI, OpenInterpreter

## Generic short post (≤ ~300 words, fits in one Discord message)

Hey everyone, just shipped something that might be useful here: **Atlas MCP** — a hosted MCP server with ~80 tools focused on markets and trading.

Why it might matter for this server:

• Domain-specific MCP — most servers in the registry are file/shell tools; this one is markets-only
• Quotes, options chains, Greek-exposure heatmaps (DEX/GEX/VEX/TEX), fundamentals, SEC + insider data
• Real broker integrations (Alpaca, Webull, Tradier, Public, Schwab, etc.) with preview-first order placement
• Persistent workflow engine — saved cron triggers, alerts to Discord/SMS/Telegram
• Hosted streamable-HTTP, one Bearer key, works in Claude Desktop / Claude Code / Cursor / Windsurf / Codex CLI / OpenClaw

Setup is one paste in your client's `mcp.json`:

```json
{
  "mcpServers": {
    "atlas": {
      "type": "streamable-http",
      "url": "https://atlasmcp.finmanagerai.com/mcp",
      "headers": { "Authorization": "Bearer YOUR_KEY" }
    }
  }
}
```

Free tier exists for tire-kicking (~10 calls/month + 60 req/min burst).

Repo + docs: <https://github.com/finmanagerai/atlas-mcp-server>
Get a key: <https://www.mind-vest.io/atlas/dashboard>

Happy to answer anything about the tool taxonomy or the preview-first safety model. Feedback welcome.

## Variant for Anthropic/MCP Discords (more technical)

Just shipped a hosted MCP server I think the MCP-curious folks here might find interesting: **Atlas MCP**. Full tool catalog (~80) is markets-focused — quotes, options chains, Greeks, broker accounts, preview-first orders, workflows.

Two design choices I'd love feedback on:

1. **Read/preview/write tags on every tool**, surfaced via a `List-Tool-Safety` introspection tool. Agents can decide which calls are safe to run unattended. Curious if anyone's seen a better pattern than this.

2. **Preview > Place pattern for any broker-touching action.** `Place-Order` is the only path with side effects; everything else is staged. Has anyone in the MCP community converged on a standard way to express "this tool is destructive, require approval"? `_meta` annotations? Tool name conventions?

Repo (registry artifacts only): <https://github.com/finmanagerai/atlas-mcp-server>

## Notes for the poster

- Always check the channel rules before posting. Some servers require pre-approval in DMs.
- Don't @everyone or @here. Ever.
- If your account is brand-new in that server, lurk for a week first or the post will read as a drive-by.
- Replying to questions in real time is what turns a Discord post into traffic — schedule the post when you can stay online for an hour.
