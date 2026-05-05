# r/ClaudeAI

**Title:** Built an MCP server that lets Claude pull live market data, analyze options Greeks, and preview broker orders

**Body:**

For folks here using Claude Desktop / Claude Code with MCP servers — wanted to share one I built.

It's called Atlas MCP. Hosted, remote MCP server, you connect Claude with one API key and it gets ~80 tools across:

- Stock quotes, options chains, Greek exposure (DEX/GEX/VEX/TEX heatmaps)
- Connected broker accounts (Alpaca, Webull, Tradier, Public, Schwab, etc. — *not* Robinhood/Fidelity)
- Preview / multi-leg / multi-order staging — Claude builds the order, you review, you submit
- Trigger-based workflows + alerts to Discord, SMS, Telegram
- Fundamentals, earnings, analyst targets, SEC filings, insider/institutional flows

Setup in Claude Desktop is one paste into `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "atlas": {
      "type": "streamable-http",
      "url": "https://atlasmcp.finmanagerai.com/mcp",
      "headers": { "Authorization": "Bearer YOUR_ATLAS_API_KEY" }
    }
  }
}
```

Restart Claude, ask "Atlas: top-volume SPY options today" and you're off.

A few things I tried to get right that I haven't seen in many other MCP servers:

- **Read/write tags on every tool** so Claude knows which calls are safe to run unattended vs. which need confirmation. `Place-Order` is the only one that submits to a broker.
- **Workflow engine** — Claude can persist a "scan my watchlist every morning and DM me if X" workflow instead of repeating the prompt.
- **Domain-specific instead of generic** — most MCP servers I've seen are file system / shell tools. This is purpose-built for markets.

Free tier is ~10 calls/month + 60 req/min burst, enough to test it. Paid for daily use.

Repo: https://github.com/finmanagerai/atlas-mcp-server
Get a key: https://www.mind-vest.io/atlas/dashboard

Curious to hear how others have wired Claude into their trading workflows — what's missing, what would you want a market-data MCP to expose that this doesn't?
