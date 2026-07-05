#!/usr/bin/env bash
#
# Lightweight status / feedback hook for codebase-memory-mcp.
# This runs on every F_install (thanks to is_configed.sh always returning 1).
# It provides immediate visible output even when the heavy install.sh is skipped
# because the tool is already present.
#

if command -v codebase-memory-mcp &> /dev/null; then
    version=$(codebase-memory-mcp --version 2>/dev/null | head -1 || echo "installed")
    echo "✓ codebase-memory-mcp ready ($version)"
    echo "  • Graph UI:         codebase-memory-mcp --ui=true --port=9749"
    echo "  • Index a project:  tell your agent \"Index this project\""
    echo "  • CLI tools:        codebase-memory-mcp cli list_projects | search_graph | ..."
    echo "  • Update:           codebase-memory-mcp update"
    echo "  • Full re-install:  codebase-memory-mcp uninstall && F_install codebase-memory-mcp"
else
    echo "⚠ codebase-memory-mcp binary not found in PATH (may need 'source ~/.zshrc' or new shell)"
fi
