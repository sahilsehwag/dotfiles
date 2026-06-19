#!/usr/bin/env bash
# Re-register chrome-devtools-mcp MCP server with agents
#
# We only auto-register for harnesses that provide a simple, non-interactive
# CLI command to add an MCP server. This is safe to run during `F_install`
# and can be re-run anytime.
#
# Many other harnesses exist (Cursor, Windsurf, Cline, Warp, JetBrains, Kiro,
# Antigravity, etc.). For those we still document the exact method in the
# reference, because they use:
#   - UI / Settings dialogs
#   - Interactive flows
#   - Manual JSON pasting
#   - Special prerequisites (e.g. running browser first)
#   - Plugin/extension marketplaces (for Skills)

echo "Re-registering chrome-devtools MCP server with available agents..."

registered=0

register() {
    local name="$1"
    shift
    echo "→ $name"
    "$@" 2>&1 | cat || true
    registered=1
}

# Detect and register using the appropriate command
if command -v claude &>/dev/null; then
    register claude claude mcp add chrome-devtools --scope user npx chrome-devtools-mcp@latest
fi

if command -v gemini &>/dev/null; then
    register gemini gemini mcp add chrome-devtools npx chrome-devtools-mcp@latest
fi

if command -v code &>/dev/null; then
    register "code (VS Code)" code --add-mcp '{"name":"chrome-devtools","command":"npx","args":["-y","chrome-devtools-mcp@latest"]}'
fi

if command -v amp &>/dev/null; then
    register amp amp mcp add chrome-devtools -- npx chrome-devtools-mcp@latest
fi

if command -v codex &>/dev/null; then
    register codex codex mcp add chrome-devtools -- npx chrome-devtools-mcp@latest
fi

if command -v cmd &>/dev/null; then
    register "cmd (Command Code)" cmd mcp add chrome-devtools --scope user npx chrome-devtools-mcp@latest
fi

if command -v droid &>/dev/null; then
    register "droid (Factory)" droid mcp add chrome-devtools "npx -y chrome-devtools-mcp@latest"
fi

if command -v qodercli &>/dev/null; then
    register "qodercli (Qoder CLI)" qodercli mcp add chrome-devtools -- npx chrome-devtools-mcp@latest
fi

# Note: We only include harnesses here that have a reliable, non-interactive
# CLI one-liner. See the reference doc for the (much larger) full list of
# supported agents and their manual setup methods.

if [[ $registered -eq 0 ]]; then
    echo "No supported agent CLIs found in PATH."
    echo "See .claude/references/chrome-devtools-mcp/setup.md for manual instructions per agent."
else
    echo ""
    echo "Done. Restart / reload your agent(s) to load the MCP server."
    echo "Reminder: This only registers the raw MCP tools."
    echo "For Skills (guided usage), install the plugin/extension from inside the agent."
fi


