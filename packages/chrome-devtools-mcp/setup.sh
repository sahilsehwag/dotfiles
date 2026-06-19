#!/usr/bin/env bash
# Setup / verification for chrome-devtools-mcp package
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

echo "Setting up Chrome DevTools MCP..."

if ! command -v chrome-devtools &> /dev/null; then
    echo "✗ chrome-devtools CLI not found in PATH"
    echo "  Try: npm install -g chrome-devtools-mcp@latest"
    echo "  Or reload shell if using nvm."
    return 1
fi

chrome-devtools --version 2>/dev/null || echo "(version check)"

echo "Running status check..."
chrome-devtools status 2>/dev/null || echo "(daemon not running yet — normal until first CLI or MCP tool use)"

echo ""
echo "✓ chrome-devtools-mcp CLI ready."

# Delegate MCP server registration to the reusable script.
# This attempts to register (MCP-only) with any agent CLIs present.
if [ -f "$script_directory/scripts/register.sh" ]; then
    bash "$script_directory/scripts/register.sh"
else
    echo ""
    echo "MCP registration script not found — run manually via agent CLIs if desired."
fi

echo ""
echo "Full per-agent instructions (MCP-only vs full Skills bundles):"
echo "  .claude/references/chrome-devtools-mcp/setup.md"
echo ""
echo "See also: https://github.com/ChromeDevTools/chrome-devtools-mcp"
