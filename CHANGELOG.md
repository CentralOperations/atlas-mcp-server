# Changelog

All notable changes to the public Atlas MCP registry artifacts in this repository. The hosted server itself is versioned separately at https://atlasmcp.finmanagerai.com.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Per-client install recipes under `docs/`: Claude Desktop, Claude Code, Cursor, Windsurf, OpenAI Codex CLI, OpenClaw, Docker stdio bridge.
- `SKILL.md` so AI agents can install and use Atlas MCP end-to-end.
- Reference docs: `docs/tools.md` (catalog with read/write classification), `docs/security.md` (auth, rate limits, permissions), `docs/examples.md` (prompt → tool mapping), `docs/ci.md` (smoke-test pattern).
- `examples/mcp.json` and `examples/smoke-test.sh`.

## [1.0.0] — initial registry submission

### Added
- `server.json` — registry manifest pointing to the hosted Atlas MCP endpoint at `https://atlasmcp.finmanagerai.com/mcp` (streamable-HTTP, Bearer auth).
- `.github/workflows/publish.yml` — tag-driven publish via `mcp-publisher` + GitHub OIDC.
- `README.md` — install + capability overview.
- `.gitignore` — ignore `mcp-publisher` local auth state.
