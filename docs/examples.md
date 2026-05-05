# Atlas MCP — Example Prompts

A grab-bag of natural-language prompts that route to the right tools. Use these to verify your install or as starting points for your own agents.

## Quick checks (read-only, free-tier friendly)

> Get me a quote for SPY.

→ `Stock-Quote({"symbol":"SPY"})`

> What are the next 10 SPY option expirations?

→ `Option-Expiration-Dates({"symbol":"SPY","filter":"next_10"})`

> Show me NVDA's earnings dates and the most recent analyst price targets.

→ `Earnings-Dates` + `Analyst-Price-Targets`

## Options flow

> Top 20 highest-volume contracts on QQQ today.

→ `Top-Volume-and-OI-Contracts({"symbol":"QQQ","sort_by":"volume","limit":20})`

> For TSLA's nearest expiration, where is gamma concentrated?

→ `Gamma-Exposure-Heatmap({"symbol":"TSLA"})` + `Analyze-Greek-Exposures`

> Pull the historical chain for AAPL on 2026-01-17 and chart implied vol around the strike at $200.

→ `Historical-Options-Chain` + `Historical-Strike-Quotes`

## Multi-symbol research

> Compare NVDA, AMD, and AVGO on the same dashboard: 1Y price, last quarter income statement, and analyst targets.

→ `Multi-Chart-View` + `Income-Statement` (×3) + `Analyst-Price-Targets` (×3)

## Account & broker

> What's my buying power across all connected brokers, and which positions are up the most this week?

→ `Broker-Connections` + `Account-Balances` + `All-Account-Holdings`

> Show me the last 30 days of fills on my Tradier account.

→ `Transaction-History`

## Order staging (preview only)

> Preview buying 5 shares of NVDA and 5 shares of AMD on my Alpaca account. Do **not** submit.

→ `Preview-Multiple-Orders` (✅ stops here)

> List my pending preview orders.

→ `List-Preview-Orders`

## Triggers & workflows

> If QQQ closes above 430 today, send a Discord alert and stage a 1-contract long call at the next-week ATM strike.

→ `Create-Trading-Trigger` (with workflow body that calls `Preview-Order` + a Discord alert step)

> Run my "morning watchlist scan" workflow now.

→ `Workflow-Run({"name":"morning watchlist scan"})`

## Strategy notes

> Save my "QQQ gamma squeeze" notes as an Atlas strategy and auto-fetch the inputs each morning.

→ `Strategy-Create` + `Autofetch-Strategy`

## Things to NOT prompt for

These will fail or be refused by Atlas:

- "Trade Robinhood / Fidelity for me" — unsupported.
- "Read /home/me/secrets.env" — Atlas has no local file access.
- "Run `rm -rf /`" — Atlas has no shell tool.
- "Show another user's positions" — bearer is bound to the authenticated user.
