# r/mcp

**Title:** A domain-specific MCP server for markets and trading (~80 tools, hosted, broker-connected)

**Body:**

Most MCPs in the wild are generic — file system, shell, GitHub, web fetch. I wanted to share a different shape: a hosted, domain-specific MCP focused on markets and trading.

What's in the catalog (`tools/list` returns the full thing):

- **Stocks:** quotes, OHLCV, multi-timeframe overviews, ticker/company search, peers
- **Options:** chains, expirations, strike-level details, historical chains, top-volume / top-OI contracts
- **Greek exposure:** DEX / GEX / VEX / TEX heatmaps, net-exposure charts, structured analyzer
- **Fundamentals:** income / balance / cashflow, analyst targets and revisions, earnings, SEC filings, insider + institutional, lobbying & USA spending data
- **Brokers:** balances, holdings, transaction history (Alpaca, Webull, Tradier, Public, Schwab, ~20 others — Robinhood and Fidelity are *not* supported for trading)
- **Orders:** preview single + multi-leg, list/delete previews, place
- **Triggers + workflows:** persistent rules, workflow runs, Discord / SMS / Telegram alerts
- **Strategy notes:** create/preview/save research with auto-fetched inputs

Two things I think matter for the MCP ecosystem more broadly:

**1. Preview-first writes.** Every tool is tagged 🟢 read / 🟡 preview / 🔴 write. `Place-Order` is the only path that hits a broker for real, and it's intended to require explicit user approval. The repo includes a `SKILL.md` so agents pick this up on install.

**2. Hosted streamable-HTTP.** Connect with one Bearer key — no compile, no daemon to babysit. URL is `https://atlasmcp.finmanagerai.com/mcp`. Tradeoff: latency floor, but updates ship without anyone redeploying.

Install recipes are in `docs/` (Claude Desktop, Claude Code, Cursor, Windsurf, Codex CLI, OpenClaw, Docker stdio bridge for clients that don't speak streamable-HTTP yet).

Free tier exists for kicking the tires (~10 calls/month, ~60 req/min burst).

Repo: https://github.com/finmanagerai/atlas-mcp-server
Key: https://www.mind-vest.io/atlas/dashboard

Happy to answer questions about the tool taxonomy or the safety model — both feel under-discussed in MCP-land.
