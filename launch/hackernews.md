# Show HN — Atlas MCP

**Title (≤ 80 chars):**
Show HN: Atlas MCP – a hosted MCP server with ~80 tools for stocks, options, brokers

**URL:** `https://github.com/finmanagerai/atlas-mcp-server` (or the dashboard)

**First comment (the part that actually matters on HN):**

Hey HN — I've been building Atlas for the last [N] months and just shipped it as an MCP server.

Most MCP servers I've seen expose generic tools (file system, shell, GitHub). Atlas is the opposite: it's a domain-specific MCP for markets and trading. ~80 tools spanning:

- Live quotes, OHLCV, options chains, expirations, strike-level Greeks
- Greek-exposure analytics — DEX, GEX, VEX, TEX heatmaps and net-exposure charts
- Connected broker accounts (Alpaca, Webull, Tradier, Public, Schwab and ~20 others — Robinhood/Fidelity are not supported for trading)
- **Preview-first** order placement: agents stage orders, you (or the agent with explicit confirmation) submit
- Persistent triggers + a workflow engine you can wire to Discord / SMS / Telegram
- Fundamentals (income/balance/cashflow), analyst targets, earnings calendars, SEC filings, insider/institutional/lobbying data

Two design choices I think are worth discussing:

1. **Hosted, not self-hosted.** Agents connect via streamable-HTTP at `https://atlasmcp.finmanagerai.com/mcp` with a Bearer key from the user's dashboard. Tradeoff: latency floor, but zero install on the client side and you can update the tool catalog without users redeploying anything.

2. **Read/write classification baked into the tool list.** Every tool is tagged read / preview / write. `Place-Order` is the only path that hits a broker for real, and it lives behind explicit user approval. Felt important once I started seeing agents loop on tool calls.

Open to feedback on the safety model and the tool taxonomy specifically — both of those decisions feel under-explored in the broader MCP ecosystem.

Repo (registry artifacts only — server source is private): https://github.com/finmanagerai/atlas-mcp-server

Get a key: https://www.mind-vest.io/atlas/dashboard

---

## Notes for the poster

- HN dislikes marketing prose. Strip any adjective that's not load-bearing before submitting.
- Don't use emoji.
- Be ready to answer in real time for the first hour — that's when the algorithm decides if it lives.
- If asked "is this open source?", be direct: registry artifacts and docs are; the trading server itself isn't.
- If asked about pricing, link the dashboard. Don't argue subscription tiers in the thread.
