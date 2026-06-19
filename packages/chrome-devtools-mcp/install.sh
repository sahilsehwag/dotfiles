#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

echo "Installing chrome-devtools-mcp global CLI..."

# Use npm (node/nvm should be handled by deps or preset)
if command -v npm &> /dev/null; then
    npm install -g chrome-devtools-mcp@latest
else
    echo "✗ npm not available. Install node first (F_install node)."
    return 1
fi

# Verify and run post-setup (this will also attempt to register the MCP server
# with any agent CLIs it finds, e.g. claude / gemini / code)
if command -v chrome-devtools &> /dev/null; then
    if [ -f "$script_directory/setup.sh" ]; then
        bash "$script_directory/setup.sh"
    fi
else
    echo "⚠ chrome-devtools not yet in PATH (nvm shell may need reload)."
fi
