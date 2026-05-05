# Atlas MCP — Tool Catalog

All tools exposed by `https://atlasmcp.finmanagerai.com/mcp`. Names match what your client will display (with whatever prefix it adds, e.g. `mcp__atlas__`).

Legend:
- 🟢 **read** — pure data fetch, no side effects
- 🟡 **write (preview)** — creates draft / preview state your account can later commit
- 🔴 **write (live)** — touches a broker, a workflow run, or fires alerts; requires explicit user approval

---

## Stocks & quotes

| Tool | Side | Purpose |
|---|---|---|
| `Stock-Quote` | 🟢 | Latest quote for a symbol |
| `Price-Data-OHLCV` | 🟢 | Historical OHLCV |
| `Price-Chart` | 🟢 | Rendered price chart |
| `Multi-Chart-View` | 🟢 | Side-by-side chart grid |
| `Multi-Timeframe-Price-Overview` | 🟢 | Same symbol across timeframes |
| `Ticker-Symbol-Lookup` | 🟢 | Resolve company name → ticker |
| `Search` | 🟢 | Generic search across symbols & news |
| `Stock-Peers` | 🟢 | Comparable companies |

## Options

| Tool | Side | Purpose |
|---|---|---|
| `Options-Chain` | 🟢 | Full chain for an expiration |
| `Option-Expiration-Dates` | 🟢 | Available expirations |
| `Strike-Price-Details` | 🟢 | Quote + Greeks for a single contract |
| `Historical-Options-Chain` | 🟢 | Snapshot at a past date |
| `Historical-Strike-Quotes` | 🟢 | Time series for one contract |
| `Top-Volume-and-OI-Contracts` | 🟢 | Top contracts by volume / OI (data) |
| `Top-Volume-Contracts-Chart` | 🟢 | Same as above, chart |
| `Top-Open-Interest-Chart` | 🟢 | Top contracts by OI, chart |
| `Volume-and-Open-Interest-Charts` | 🟢 | Volume & OI overlays |

## Greek exposures

| Tool | Side | Purpose |
|---|---|---|
| `Analyze-Greek-Exposures` | 🟢 | Structured GEX/DEX/VEX/TEX summary |
| `Delta-Exposure-Heatmap` | 🟢 | DEX heatmap |
| `Gamma-Exposure-Heatmap` | 🟢 | GEX heatmap |
| `Theta-Exposure-Heatmap` | 🟢 | TEX heatmap |
| `Vanna-Exposure-Heatmap` | 🟢 | Vanna heatmap |
| `All-Greek-Heatmaps` | 🟢 | All four in one shot |
| `Net-Delta-Exposure-Chart` | 🟢 | Net DEX chart |
| `Net-Gamma-Exposure-Chart` | 🟢 | Net GEX chart |
| `Net-Theta-Exposure-Chart` | 🟢 | Net TEX chart |
| `Net-Vanna-Exposure-Chart` | 🟢 | Net Vanna chart |
| `All-Net-Exposure-Charts` | 🟢 | All four in one shot |

## Fundamentals & research

| Tool | Side | Purpose |
|---|---|---|
| `Income-Statement` | 🟢 | |
| `Balance-Sheet` | 🟢 | |
| `Cashflow-Statement` | 🟢 | |
| `Financial-Metrics` | 🟢 | Key ratios |
| `Earnings-Calendar` | 🟢 | Upcoming earnings |
| `Earnings-Dates` | 🟢 | Past + next for a symbol |
| `EPS-Estimates` | 🟢 | |
| `EPS-Revisions` | 🟢 | |
| `EPS-Trend` | 🟢 | |
| `Revenue-Estimates` | 🟢 | |
| `Growth-Estimates` | 🟢 | |
| `Analyst-Price-Targets` | 🟢 | |
| `Analyst-Upgrades-and-Downgrades` | 🟢 | |
| `Dividends-and-Splits` | 🟢 | |
| `IPO-Calendar` | 🟢 | |
| `SEC-Filings` | 🟢 | Recent filings |
| `Insider-Transactions` | 🟢 | |
| `Institutional-Holders` | 🟢 | |
| `Senate-Lobbying-Data` | 🟢 | |
| `USA-Spending-Data` | 🟢 | |
| `Chart-Vision-Analysis` | 🟢 | LLM read of an uploaded chart |

## Broker accounts

| Tool | Side | Purpose |
|---|---|---|
| `Broker-Connections` | 🟢 | List connected brokers |
| `Account-Balances` | 🟢 | Cash, BP, equity for one account |
| `Account-Holdings` | 🟢 | Positions for one account |
| `All-Account-Holdings` | 🟢 | Positions across all accounts |
| `Account-Symbol-Lookup` | 🟢 | Resolve a symbol within an account |
| `Transaction-History` | 🟢 | Past fills / cash movements |
| `Subscription-Status` | 🟢 | Your Atlas plan, quota, and remaining |

## Orders

| Tool | Side | Purpose |
|---|---|---|
| `Preview-Order` | 🟡 | Stage a single order (no broker submit) |
| `Preview-Multiple-Orders` | 🟡 | Stage a batch |
| `List-Preview-Orders` | 🟢 | List staged previews |
| `Delete-Preview-Order` | 🟡 | Drop a staged preview |
| `Place-Order` | 🔴 | **Submits to the broker.** Requires explicit user confirmation. |

## Trading triggers

| Tool | Side | Purpose |
|---|---|---|
| `Create-Trading-Trigger` | 🔴 | New price / time trigger |
| `Update-Trading-Trigger` | 🔴 | Edit a trigger |
| `Delete-Trading-Trigger` | 🔴 | Remove |
| `List-Trading-Triggers` | 🟢 | |
| `List-Fired-Triggers` | 🟢 | History of fires |
| `Reactivate-Trigger` | 🔴 | Re-arm |
| `Preview-Trading-Trigger` | 🟡 | Dry-run |
| `Trigger-Workflow-Schema` | 🟢 | JSON schema for trigger payloads |

## Workflows

| Tool | Side | Purpose |
|---|---|---|
| `Workflow-Create` | 🔴 | New workflow |
| `Workflow-Update` | 🔴 | |
| `Workflow-Delete` | 🔴 | |
| `Workflow-Open` | 🟢 | Read one |
| `Workflow-Run` | 🔴 | **Executes** — may send alerts, place trades, etc. |
| `Workflow-Preview` | 🟡 | Dry-run |
| `Workflow-Import` | 🔴 | Import from JSON |
| `Workflow-Logs` | 🟢 | Past run logs |

## Strategy notes

| Tool | Side | Purpose |
|---|---|---|
| `Strategy-Create` | 🟡 | New strategy doc |
| `Strategy-Update` | 🟡 | |
| `Strategy-Open` | 🟢 | Read one |
| `Strategy-Preview` | 🟢 | Render preview |
| `Strategy-Import` | 🟡 | Import |
| `Fetch-Strategy` | 🟢 | Pull data referenced by a strategy |
| `Autofetch-Strategy` | 🟢 | Auto-pull every input |
| `List-Strategy` | 🟢 | |
| `Strategy-Save-Instructions` | 🟡 | Persist instruction template |

## Misc

| Tool | Side | Purpose |
|---|---|---|
| `Get-Instructions` | 🟢 | Returns the human-readable usage hint for the server |
| `List-Tool-Safety` | 🟢 | Returns the read/write classification for every tool |
| `Fetch-URL` | 🟢 | Server-side fetch of a public URL (no local credentials) |

---

## Inputs & outputs

Use `Get-Instructions` after install to receive parameter hints in the agent's own prompt format. Most tools accept a `symbol` (e.g. `"SPY"`) plus optional filters (`expiration`, `limit`, `sort_by`).

The wire-level catalog with example payloads also lives at https://www.mind-vest.io/atlas-tools.json — useful for code generation against Atlas's REST endpoints if you're not going through MCP.
