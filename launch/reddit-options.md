# r/options + r/thetagang (light variant)

**Title (r/options):** Built an MCP server that gives Claude/ChatGPT real options chains, Greek exposure heatmaps, and broker-staged orders

**Title (r/thetagang):** AI tool that actually reads dealer Greeks + stages multi-leg orders (not just "what is theta")

**Body:**

I got tired of asking Claude/ChatGPT options questions and getting "definition of gamma" answers when what I needed was *the actual chain*. So I built a hosted MCP server that exposes the data and the workflow.

What it does for options specifically:

- Full chains for any expiration, including historical chains for backtesting context
- Top-volume + top-OI contracts as data *and* as charts
- Strike-level Greeks
- DEX / GEX / VEX / TEX heatmaps and net-exposure charts — the structured-product "where's dealer gamma stacked" reads
- `Analyze-Greek-Exposures` — one call, structured regime read across multiple expirations

For order flow:

- `Preview-Order` and `Preview-Multiple-Orders` for multi-leg structures (verticals, condors, calendars, ratios)
- Submits only via explicit `Place-Order` after you approve — agents can't accidentally submit
- Brokers: Alpaca, Webull, Tradier, Public, Schwab, etc. (not Robinhood, not Fidelity)

Example prompt that I use daily:

> "For TSLA's nearest two expirations, where is gamma concentrated, and what's the IV smile look like? Then stage a 1-contract long call calendar at the highest-gamma strike — preview only."

That goes out as ~3 tool calls and comes back with the chain, a heatmap, and a staged order I can review and submit.

Free tier (~10 calls/month) is enough to try it. Paid for daily use.

Repo: https://github.com/finmanagerai/atlas-mcp-server
Key: https://www.mind-vest.io/atlas/dashboard

If anyone here uses MCPs already, would love feedback on the Greek tool taxonomy specifically — the line between "give me the chain" and "give me the read" is fuzzy and I'd rather hear it from people who trade these than guess.

---

## Notes for the poster

- r/options is allergic to anything that smells like a pump. Lead with the actual capability, not the brand.
- r/thetagang likes specifics — the calendar prompt above resonates more than abstract "AI for options" framing.
- Skip the link in the body if rules require — drop it as a top-level comment after the post lands.
