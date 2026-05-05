# Product Hunt — Atlas MCP

**Tagline (≤ 60 chars):**
The MCP server that gives AI agents broker-aware market tools

**Description (≤ 260 chars):**
Atlas is a hosted MCP server with ~80 tools for stocks, options, Greek exposures, broker accounts, preview-first orders, and workflow automation. Connect Claude, Cursor, Codex, or any MCP client with one API key — no install, no daemon.

**First comment (the launch-day pin):**

Hey Hunters 👋

I built Atlas because I kept watching AI agents *talk* about markets without being able to *do* anything in them. They could explain gamma exposure but couldn't pull the chain. They could draft a covered-call but couldn't see your buying power.

So Atlas exposes the boring connective tissue as MCP tools:

🔹 Live quotes, OHLCV, multi-timeframe price views
🔹 Full options chains, Greeks, top volume / OI contracts
🔹 DEX / GEX / VEX / TEX heatmaps and net-exposure charts
🔹 Connected brokers: Alpaca, Webull, Tradier, Public, Schwab + ~20 more
🔹 Preview-first orders — including multi-leg and multi-order baskets
🔹 Persistent workflows + Discord / SMS / Telegram alerts
🔹 Fundamentals, analyst targets, SEC filings, insider + lobbying data

Three design choices I'd love feedback on:

1. **Hosted, not self-hosted.** One Bearer key, no compile. Tradeoff is a latency floor, but updates ship without users redeploying.
2. **Preview > Place.** Every tool is tagged read/preview/write. `Place-Order` is the only path that hits a broker; agents can't accidentally fire a trade.
3. **Workflow-first automation.** Saved workflows (cron + triggers + alerts) instead of asking the agent to repeat the same scan every morning.

Free tier exists for tire-kicking (~10 tool calls/month). Paid tier on the dashboard.

If you want to try it: https://www.mind-vest.io/atlas/dashboard
Docs: https://github.com/finmanagerai/atlas-mcp-server

Happy to answer anything about the tool taxonomy, the safety model, or what's coming next. Robinhood/Fidelity are not on the roadmap (their APIs aren't there) — for everything else, ask away.

---

## Notes for the launcher

- Launch on a Tuesday at 12:01am Pacific — full 24-hour leaderboard window.
- Line up 5–10 hunters in advance to upvote in the first hour.
- Reply to every comment within an hour for the whole launch day.
- Have a 30s GIF demo ready (claude.ai using Atlas to pull a chain → analyze Greeks → preview order). PH gallery slots are 270×252; the GIF goes in slot 1.
- Three screenshots minimum: (1) the install JSON, (2) Claude calling a tool, (3) a Greek heatmap.
