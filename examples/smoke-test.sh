#!/usr/bin/env bash
# Atlas MCP smoke test.
#
# Usage:
#   ATLAS_API_KEY=xxx ./smoke-test.sh
#
# Exit codes:
#   0   healthy
#   1   bad/missing API key
#   2   transport / HTTP error
#   3   tools/list returned an empty catalog
#   4   Stock-Quote returned no price

set -euo pipefail

: "${ATLAS_API_KEY:?ATLAS_API_KEY env var is required}"
ENDPOINT="${ATLAS_ENDPOINT:-https://atlasmcp.finmanagerai.com/mcp}"

req() {
  local body="$1"
  curl -sS -w '\n%{http_code}' \
    -H "Authorization: Bearer $ATLAS_API_KEY" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json, text/event-stream" \
    --data "$body" \
    "$ENDPOINT"
}

# 1) tools/list
out=$(req '{"jsonrpc":"2.0","id":1,"method":"tools/list"}')
http=$(printf '%s' "$out" | tail -n1)
body=$(printf '%s' "$out" | sed '$d')

case "$http" in
  401|403) echo "auth failed (HTTP $http) — check ATLAS_API_KEY" >&2; exit 1 ;;
  200) ;;
  *)   echo "transport error (HTTP $http)" >&2; exit 2 ;;
esac

# crude check that at least one tool is present
if ! printf '%s' "$body" | grep -q '"name"'; then
  echo "tools/list returned an empty catalog" >&2
  exit 3
fi

# 2) call Stock-Quote on SPY
out=$(req '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"Stock-Quote","arguments":{"symbol":"SPY"}}}')
http=$(printf '%s' "$out" | tail -n1)
body=$(printf '%s' "$out" | sed '$d')

if [ "$http" != "200" ]; then
  echo "Stock-Quote failed (HTTP $http)" >&2
  exit 2
fi

if ! printf '%s' "$body" | grep -qiE '"price"[[:space:]]*:[[:space:]]*[0-9]'; then
  echo "Stock-Quote returned no price field" >&2
  exit 4
fi

echo "ok"
