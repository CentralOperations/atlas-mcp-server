# Atlas MCP — Security & Permissions

## Auth model

- **Transport:** TLS 1.2+ over HTTPS, streamable-HTTP MCP (`Mcp-Session-Id` honored).
- **Auth header:** `Authorization: Bearer <ATLAS_API_KEY>`.
- **Where the key comes from:** the user's Atlas dashboard at https://www.mind-vest.io/atlas/dashboard → **API Keys**. The key is bound to the dashboard account; revocation is immediate.
- **Rotation:** generate a new key in the dashboard; the old one stops working immediately. There's no `kid`/JWT layering — the bearer is opaque and verified server-side.
- **OAuth:** Atlas also accepts standard OAuth 2.0 access tokens issued by `https://atlasmcp.finmanagerai.com` (RFC 8414 metadata published). For end-user agent flows, prefer the dashboard API key — it's simpler and scoped to the user.

## What the server can / cannot do

- **Reads:** market data (quotes, options chains, Greeks, fundamentals, calendars), the user's broker balances/positions/transactions, and the user's saved Atlas objects (strategies, workflows, triggers, preview orders).
- **Writes:** only via tools tagged 🟡 / 🔴 in [tools.md](tools.md). The 🔴 tools have side effects an agent must not invoke without explicit user approval — they place trades, fire alerts (Discord/SMS/Telegram), or run workflows.
- **No local file access.** The MCP server runs server-side; it cannot read or write files on the user's machine.
- **No shell or code execution.** Atlas does not expose a shell, REPL, or arbitrary code-execution tool.
- **No data exfiltration.** The server only returns data the authenticated user already owns or has subscribed to. There is no global "read someone else's account" tool.

## Order safety

- **Always preview first.** `Preview-Order` / `Preview-Multiple-Orders` stage an order in Atlas without sending it to the broker. The user (or the agent, with explicit user approval) then calls `Place-Order` to submit.
- **Robinhood and Fidelity are NOT supported for trading.** Read-only data may be available, but `Place-Order` will fail for those brokers.
- **Multi-leg / multi-order batches** are submitted as a single broker request to keep them atomic.

## Rate limits

| Tier | Per-minute burst | Monthly tool calls |
|---|---|---|
| Free | ~60 req/min | ~10 calls / month |
| Paid | ~60 req/min (subject to plan) | per-subscription `monthly_limit` (see `Subscription-Status`) |

When you hit a limit the server returns HTTP `429` with body:

```json
{ "error": "rate_limit", "message": "..." }
```

**Don't retry in a tight loop.** Surface the error to the user and stop.

## PII & data handling

- The bearer token is the only secret transmitted by the client.
- Tool arguments are logged at the application level for billing and abuse detection. Do not paste secrets, passwords, or PII into tool arguments.
- Broker connections live in Atlas's own backend — agents never see broker credentials.

## Reporting issues

- Security vulnerabilities: open a private security advisory on the GitHub repo or email the contact listed at https://www.mind-vest.io/.
- Functional bugs: open an issue on this repo with reproduction steps. Do **not** include your API key.
