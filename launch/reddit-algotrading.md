# r/algotrading

**Title:** I built an MCP server so my AI agent can actually do market research + stage broker orders (not just talk about them)

**Body:**

Long-time lurker, finally have something to share that's relevant.

The frustration that drove this: ChatGPT / Claude can talk about markets all day, but they can't *do* the boring connective parts — pull a real chain, check my buying power, draft an order, fire an alert when X happens. So you end up tab-jumping between broker, charting tool, screener, Discord, spreadsheet.

I built a hosted MCP server (Atlas MCP) that closes that gap. ~80 tools my agent can call:

**Data**
- Live + historical quotes, OHLCV, multi-timeframe price views
- Full options chains, expirations, historical chains, strike-level details
- Top volume / top open interest contracts
- Greek exposure analysis: DEX, GEX, VEX, TEX heatmaps + net-exposure charts
- Fundamentals + analyst targets + earnings + SEC filings + insider/institutional + congressional / federal-spending data

**Brokerage (the part most "AI for trading" tools skip)**
- Connect Alpaca, Webull, Tradier, Public, Schwab, and ~20 others (not Robinhood, not Fidelity)
- Read balances, holdings, transactions across all accounts
- Stage single, multi-leg, and multi-order previews
- Submit only after explicit approval — `Place-Order` is the only tool that hits the broker

**Automation**
- Persistent triggers (price, time, indicator-based)
- Workflow engine — a "morning watchlist scan → Discord alert → preview order on a setup" can be a saved workflow that runs on cron
- Outputs to Discord, SMS, Telegram

The architecture decision I think is most relevant to this sub: every tool is tagged read / preview / write, and I use the preview pattern aggressively. Agents are great at building order baskets and terrible at being trusted with the submit button. Preview-first lets you keep the leverage of the agent while keeping the trigger.

Two limits to be upfront about:
- It's hosted (remote streamable-HTTP MCP). Not for anyone who needs sub-millisecond colo.
- Free tier is intentionally small (~10 tool calls/month) so you can verify it works. Real daily use is paid.

Repo (registry artifacts + docs, server source is private): https://github.com/finmanagerai/atlas-mcp-server
Key: https://www.mind-vest.io/atlas/dashboard

Genuinely curious what tool would unlock the most for you. The thing I keep going back and forth on is whether to expose a Python sandbox tool for one-off custom indicators vs. forcing everyone to wait for me to add them as first-class tools. Vote below if you have an opinion.
