<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Inter&weight=700&size=28&duration=3000&pause=700&center=true&vCenter=true&width=900&lines=Atlas+MCP+Server;Give+AI+agents+market+superpowers;Analyze+markets.+Automate+workflows.+Place+orders.;Stop+jumping+between+charts%2C+brokers%2C+alerts%2C+and+spreadsheets." alt="Atlas MCP Server animated headline" />
</p>

<p align="center">
  <strong>Connect AI agents to Atlas so they can read markets, build workflows, send alerts, and place broker orders with your approval.</strong>
</p>

<p align="center">
  <a href="#install">Install</a>
  ·
  <a href="#why-atlas-mcp">Why</a>
  ·
  <a href="#what-it-can-do">What it can do</a>
  ·
  <a href="#example-prompts">Examples</a>
  ·
  <a href="#supported-tools">Tools</a>
  ·
  <a href="#faq">FAQ</a>
  ·
  <a href="#safety">Safety</a>
</p>

<p align="center">
  <img alt="MCP" src="https://img.shields.io/badge/MCP-Compatible-blue" />
  <img alt="AI Agents" src="https://img.shields.io/badge/AI%20Agents-Ready-purple" />
  <img alt="Broker Orders" src="https://img.shields.io/badge/Broker%20Orders-Supported-green" />
  <img alt="Options" src="https://img.shields.io/badge/Options-Greeks%20%7C%20OI%20%7C%20Volume-orange" />
  <img alt="Alerts" src="https://img.shields.io/badge/Alerts-Discord%20%7C%20SMS%20%7C%20Telegram-black" />
</p>

---

# Atlas MCP Server

**Stop jumping between charts, brokers, alerts, spreadsheets, and chat apps.**

Atlas MCP lets AI agents help with investing tasks in one place:

```text
Ask Agent → Analyze Market → Review Plan → Stage Orders → Automate Workflow → Send Alerts
```

<img width="1128" height="946" alt="Atlas MCP workflow" src="https://github.com/user-attachments/assets/9a98410e-1cfd-49d3-a2dd-95d5346af1fa" />

Atlas MCP gives agents a safe way to:

- Read live market data
- Analyze stocks and options
- Check broker accounts
- Stage single or multiple orders
- Send alerts to Discord, SMS, Telegram, and chat apps
- Create repeatable investing workflows

It works with agent tools like:

- OpenClaw
- Claude Desktop
- Cursor
- Cline
- ChatGPT-compatible MCP clients
- Custom agents

---

## Install

Atlas MCP is a **hosted, remote MCP server**. There's nothing to compile or self-host — your agent connects to `https://atlasmcp.finmanagerai.com/mcp` over streamable HTTP, and authenticates with your personal Atlas API key.

### 1. Get your Atlas API key

1. Go to **https://www.mind-vest.io/atlas** and sign in (or create an account).
2. Open the **Dashboard** → **API Keys** section.
3. Click **Generate key** and copy the value. Treat it like a password.

### 2. Add Atlas to your MCP client

**Claude Desktop / Claude Code / Cursor / Cline / any MCP client that reads `mcp.json`:**

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

**Claude Code one-liner:**

```bash
claude mcp add --transport http atlas https://atlasmcp.finmanagerai.com/mcp \
  --header "Authorization: Bearer YOUR_ATLAS_API_KEY"
```

**Anything that follows the MCP registry:**

```
io.github.finmanagerai/atlas-mcp-server
```

Then restart your client. Ask the agent to "show me an SPY quote" — if a quote comes back, you're connected.

### Per-client install recipes

Each recipe covers config path, install command, env vars, test prompt, and troubleshooting:

- [Claude Desktop](docs/claude-desktop.md)
- [Claude Code](docs/claude-code.md)
- [Cursor](docs/cursor.md)
- [Windsurf](docs/windsurf.md)
- [OpenAI Codex CLI](docs/codex.md)
- [OpenClaw](docs/openclaw.md)
- [Docker (stdio bridge)](docs/docker.md)

### Letting an AI agent install it for you

Drop [`SKILL.md`](SKILL.md) into your agent's skills/instructions and it will pick the right recipe, plug in the user's key, and run the smoke test on its own.

### More

- [Tool catalog](docs/tools.md) — every tool, with read/write classification
- [Security & permissions](docs/security.md) — auth model, rate limits, what Atlas can and can't do
- [Example prompts](docs/examples.md)
- [CI smoke test](docs/ci.md) + [`examples/smoke-test.sh`](examples/smoke-test.sh)
- [Changelog](CHANGELOG.md)

> **Heads-up:** This repo intentionally contains only the public configuration needed to install and discover Atlas MCP. The server implementation, broker connectors, and proprietary data pipelines are not open-sourced.

---

## Why Atlas MCP?

Most agents can explain the market.

But they usually cannot do the useful parts together:

- Check live stock data
- Read options chains
- Find high-volume or high-open-interest contracts
- Check account balances and positions
- Prepare trades across brokers
- Stage multiple orders at once
- Automate alerts and workflows
- Send updates to Discord, SMS, Telegram, or chat apps
- Keep you in control before anything is submitted

**Atlas MCP closes that gap.**

It helps agents move from:

```text
"Here is what I think."
```

to:

```text
"Here is the market data, here is the plan, here are the orders, review before sending."
```

---

## What it can do

### Market research

- Get live stock quotes
- Pull price history
- Check earnings dates
- Review analyst ratings
- Read company financials
- Compare related stocks

### Options research

- Read options chains
- Find top-volume contracts
- Find top-open-interest contracts
- Review Greeks
- Analyze Gamma, Delta, Vanna, and Theta exposure

### Broker actions

- Connect to supported brokers
- Check balances and positions
- Preview stock orders
- Preview options orders
- Stage multiple orders at once
- Submit approved orders

Supported brokers can include:

- Alpaca
- Webull
- Tradier
- Public
- 20+ popular brokers depending on your connected broker setup

> Robinhood and Fidelity are not supported for trading features.

### Alerts and workflows

- Send trade alerts to Discord
- Send SMS alerts
- Send Telegram alerts
- Create watchlist scans
- Create price-trigger workflows
- Automate daily or weekly market checks
- Deliver updates to chat apps

---

## Example prompts

```text
Show me the top-volume SPY options contracts today.
```

```text
Check my buying power and preview buying 5 NVDA and 5 AMD.
```

```text
If QQQ breaks above 430, send me a Discord alert and stage a trade for review.
```

```text
Scan my watchlist every morning and text me the best setups.
```

```text
Preview multiple orders across my connected broker account. Do not submit until I approve.
```

---

## Supported tools

Atlas MCP can expose tools for:

- Stocks
- Options
- Greeks
- Charts
- Broker accounts
- Order previews
- Order placement
- Trading triggers
- Workflow automation
- Strategy notes
- Discord alerts
- SMS alerts
- Telegram alerts

---

## FAQ

### Is Atlas MCP a trading bot?

No. Atlas MCP is a tool layer for AI agents. It helps agents read data, create workflows, preview orders, and send alerts. You stay in control.

### Can it place real orders?

Yes, when broker connections and permissions are enabled. The safest flow is preview first, then submit only after approval.

### Can it submit multiple orders at once?

Yes. Atlas MCP can stage multiple orders together, so you do not have to enter each trade one by one.

### Can it trade options?

Yes, when your broker connection supports options trading. Atlas MCP can help with options chains, contract lookup, Greeks, and order previews.

### Does it support Discord, SMS, and Telegram?

Yes. Workflows can send alerts, summaries, and trade updates to Discord, SMS, Telegram, and chat apps.

### Does it support Webull, Alpaca, Tradier, and Public?

Yes. Atlas MCP can support broker workflows through Alpaca, Webull, Tradier, Public, and 20+ popular brokers depending on your enabled broker connection.

### Does it support Robinhood or Fidelity trading?

No. Trading features are not available for Robinhood and Fidelity.

### Is this financial advice?

No. Atlas MCP is software for market research and workflow automation. It does not give financial advice.

---

## Safety

This project is for education, research, and workflow automation only.

Trading stocks, options, and other assets is risky. You are responsible for your own trades, broker connections, order approvals, automation settings, and results.

Always review orders before submitting them.
