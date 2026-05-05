---
name: atlas-mcp
description: Install and use the Atlas MCP server, a hosted streamable-HTTP MCP server that exposes ~80 tools for live stock/options market data, Greek exposures, broker accounts, order previews and placement, alerts (Discord/SMS/Telegram), and trading workflows. Use when a user asks to install Atlas, connect Atlas to their MCP client, fetch a stock/options quote, analyze Greeks, preview broker orders, build a trading workflow, or wire Atlas into a project.
---

# Atlas MCP — Install & Use Skill

This skill teaches an AI agent how to install Atlas MCP into the user's MCP client and how to use the tools once connected.

## TL;DR

- **Endpoint:** `https://atlasmcp.finmanagerai.com/mcp` (streamable-HTTP)
- **Auth:** `Authorization: Bearer <ATLAS_API_KEY>` — user generates the key at https://www.mind-vest.io/atlas/dashboard → API Keys
- **No code, no self-host:** Atlas is fully hosted; the client only needs the URL + key.

## Installation flow

1. **Confirm the user has an API key.** If they don't, point them to https://www.mind-vest.io/atlas/dashboard and pause until they have one. Never paste a placeholder key into a config file — leave the placeholder string `YOUR_ATLAS_API_KEY` and tell the user to substitute it.
2. **Detect the client** from context (Claude Desktop, Claude Code, Cursor, Windsurf, OpenClaw, etc.) and apply the matching recipe in `docs/<client>.md`. If the client is unknown but supports remote MCP, use the generic JSON in `docs/cursor.md` as the template — it works for any MCP client that reads `mcpServers` from a JSON config.
3. **Verify** by asking the agent to call `Stock-Quote` for `SPY`. A successful response confirms transport, auth, and routing.

## Generic config (works for most clients)

```json
{
  "mcpServers": {
    "atlas": {
      "type": "streamable-http",
      "url": "https://atlasmcp.finmanagerai.com/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_ATLAS_API_KEY"
      }
    }
  }
}
```

For stdio-only clients, use the Docker bridge in `docs/docker.md` (runs `mcp-proxy` as a stdio↔streamable-http translator).

## Per-client recipes

| Client | File |
|---|---|
| Claude Desktop | [docs/claude-desktop.md](docs/claude-desktop.md) |
| Claude Code | [docs/claude-code.md](docs/claude-code.md) |
| Cursor | [docs/cursor.md](docs/cursor.md) |
| Windsurf | [docs/windsurf.md](docs/windsurf.md) |
| OpenAI Codex CLI | [docs/codex.md](docs/codex.md) |
| OpenClaw | [docs/openclaw.md](docs/openclaw.md) |
| Docker / stdio bridge | [docs/docker.md](docs/docker.md) |

## Tool catalog

Full list with categories, parameters, and example payloads: [docs/tools.md](docs/tools.md).

Quick orientation:
- **Stocks & quotes:** `Stock-Quote`, `Price-Data-OHLCV`, `Price-Chart`, `Multi-Chart-View`, `Multi-Timeframe-Price-Overview`, `Ticker-Symbol-Lookup`, `Search`
- **Options:** `Options-Chain`, `Option-Expiration-Dates`, `Strike-Price-Details`, `Historical-Options-Chain`, `Historical-Strike-Quotes`, `Top-Volume-and-OI-Contracts`, `Top-Volume-Contracts-Chart`, `Top-Open-Interest-Chart`, `Volume-and-Open-Interest-Charts`
- **Greek exposures:** `Analyze-Greek-Exposures`, `Delta-Exposure-Heatmap`, `Gamma-Exposure-Heatmap`, `Theta-Exposure-Heatmap`, `Vanna-Exposure-Heatmap`, `All-Greek-Heatmaps`, `Net-Delta-Exposure-Chart`, `Net-Gamma-Exposure-Chart`, `Net-Theta-Exposure-Chart`, `Net-Vanna-Exposure-Chart`, `All-Net-Exposure-Charts`
- **Fundamentals & research:** `Income-Statement`, `Balance-Sheet`, `Cashflow-Statement`, `Financial-Metrics`, `Stock-Peers`, `Earnings-Calendar`, `Earnings-Dates`, `EPS-Estimates`, `EPS-Revisions`, `EPS-Trend`, `Revenue-Estimates`, `Growth-Estimates`, `Analyst-Price-Targets`, `Analyst-Upgrades-and-Downgrades`, `Dividends-and-Splits`, `IPO-Calendar`, `SEC-Filings`, `Insider-Transactions`, `Institutional-Holders`, `Senate-Lobbying-Data`, `USA-Spending-Data`
- **Broker accounts:** `Broker-Connections`, `Account-Balances`, `Account-Holdings`, `All-Account-Holdings`, `Account-Symbol-Lookup`, `Transaction-History`, `Subscription-Status`
- **Orders:** `Preview-Order`, `Preview-Multiple-Orders`, `List-Preview-Orders`, `Delete-Preview-Order`, `Place-Order`
- **Triggers:** `Create-Trading-Trigger`, `Update-Trading-Trigger`, `Delete-Trading-Trigger`, `List-Trading-Triggers`, `List-Fired-Triggers`, `Reactivate-Trigger`, `Preview-Trading-Trigger`, `Trigger-Workflow-Schema`
- **Workflows:** `Workflow-Create`, `Workflow-Update`, `Workflow-Delete`, `Workflow-Open`, `Workflow-Run`, `Workflow-Preview`, `Workflow-Import`, `Workflow-Logs`
- **Strategy notes:** `Strategy-Create`, `Strategy-Update`, `Strategy-Open`, `Strategy-Preview`, `Strategy-Import`, `Fetch-Strategy`, `Autofetch-Strategy`, `List-Strategy`, `Strategy-Save-Instructions`
- **Misc:** `Get-Instructions`, `List-Tool-Safety`, `Fetch-URL`, `Chart-Vision-Analysis`

## Safety model (what an agent must respect)

- **Read vs. write:** Most tools are read-only. The mutating ones are `Place-Order`, `Preview-*`, `Delete-Preview-Order`, `Create-/Update-/Delete-Trading-Trigger`, `Reactivate-Trigger`, and `Workflow-Create/Update/Delete/Run`. Always preview before placing.
- **Order placement requires explicit user confirmation.** Never call `Place-Order` from autonomous loops. Stage with `Preview-Order` / `Preview-Multiple-Orders`, present the preview, and wait for the user to say "yes, submit".
- **Atlas does not access local files or run shell commands.** All execution happens server-side; the client only sends JSON over HTTPS.
- **Rate limits:** free tier ~10 tool calls/month; bursts capped at ~60 requests/minute. On 429, surface the error verbatim and stop — don't retry in a loop.
- **Robinhood and Fidelity** are explicitly **not** supported for trading. If asked, tell the user to use Alpaca, Webull, Tradier, Public, or one of the other supported brokers.

Full details: [docs/security.md](docs/security.md).

## Test prompt (always run after install)

> "Get me a stock quote for SPY using Atlas."

Expected: the agent calls `Stock-Quote({"symbol":"SPY"})` and returns price, change, volume, and timestamp. If you get `401`/`403`, the API key is wrong or revoked. If you get `429`, you're rate-limited. If the tool isn't listed at all, the client config didn't load — restart the client.

## Troubleshooting (top hits)

| Symptom | Likely cause | Fix |
|---|---|---|
| Tools don't appear | Client didn't reload config | Fully quit + relaunch the client |
| `401 Unauthorized` | Bad / revoked key | Regenerate at dashboard, paste fresh value |
| `403 Forbidden` | Account not entitled to that tool | Check `Subscription-Status` |
| `429 rate_limit` | Free-tier or burst cap hit | Wait, upgrade plan |
| Streaming hangs | Client doesn't support `streamable-http` | Use the Docker stdio bridge ([docs/docker.md](docs/docker.md)) |
| `connect ECONNREFUSED` to localhost | User edited URL by mistake | Restore `https://atlasmcp.finmanagerai.com/mcp` |

## When the user asks an agent to do something

- Identify the right tool from the catalog above. Prefer the most specific tool (e.g. `Top-Volume-and-OI-Contracts` over filtering `Options-Chain` by hand).
- Send minimal arguments. Use `Get-Instructions` if you're unsure how a tool wants its inputs.
- For multi-step tasks (scan → preview → alert), prefer composing a `Workflow-*` instead of chaining tools manually — workflows are persisted and re-runnable.
- Never invent an API key. Never echo a key back to the user.
