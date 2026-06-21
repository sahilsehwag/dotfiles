#!/usr/bin/env bash
#
# codebase-memory-mcp package for dotfiles
#
# Installs the official codebase-memory-mcp — the fastest and most efficient
# code intelligence engine for AI coding agents.
#
# From https://github.com/DeusData/codebase-memory-mcp :
#   - Single static binary (zero dependencies, pure C where possible)
#   - 158 languages via vendored tree-sitter grammars
#   - Hybrid LSP semantic type resolution for 9+ languages (Python, TS/JS/TSX/JSX,
#     PHP, C#, Go, C, C++, Java, Kotlin, Rust)
#   - Builds a persistent local knowledge graph (functions, classes, calls,
#     HTTP routes, cross-service links, etc.)
#   - 14 MCP tools: index_repository, search_graph, trace_path, detect_changes,
#     query_graph (openCypher subset), get_architecture, semantic search, etc.
#   - Extreme performance: avg repo in milliseconds; Linux kernel (28M LOC)
#     full index in ~3 minutes on Apple M3 Pro. Queries <1-10ms.
#   - 120x fewer tokens (example: 5 queries ~3.4k vs ~412k tokens file-by-file)
#   - Auto-detects + configures 11 agents (Claude Code, Codex, Gemini CLI,
#     Zed, OpenCode, etc.): writes MCP entries, instruction files, non-blocking
#     PreToolUse/SessionStart hooks.
#   - Optional UI variant: interactive 3D graph visualization at localhost:9749
#   - CLI mode also available: codebase-memory-mcp cli ...
#   - Commands after install: update, uninstall, config, cli
#
# The install script here uses the exact one-liner the user requested (with --ui):
#   curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash -s -- --ui
#
# Options supported by upstream: --ui (graph viz), --skip-config, --dir=...
#
# After install:
#   - Restart your coding agent
#   - Say "Index this project" (or call index_repository)
#   - Optional: codebase-memory-mcp config set auto_index true
#   - UI: codebase-memory-mcp --ui=true --port=9749
#
# All processing 100% local. Binaries are signed + checksummed + VirusTotal scanned.
# Research paper: arXiv:2603.27277
#

script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

echo "Installing codebase-memory-mcp (with graph visualization UI) via official installer..."
echo "  curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash -s -- --ui"
echo ""
echo "Key facts (from project README):"
echo "  • Fastest structural indexing for agents (ms for normal repos, 3min for Linux kernel)"
echo "  • 158 languages + Hybrid LSP → rich knowledge graph (CALLS, HTTP_CALLS, etc.)"
echo "  • 14 MCP tools + CLI access (search_graph, trace_path, detect_changes, get_architecture...)"
echo "  • --ui builds the UI variant (3D viz on localhost:9749)"
echo "  • Auto-configures MCP + hooks/skills for Claude Code / other agents it detects"
echo ""

curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash -s -- --ui

echo ""
echo "✓ codebase-memory-mcp install script completed."
echo ""
echo "Next steps:"
echo "  1. Restart your coding agent (Claude Code, Cursor, Gemini CLI, etc.)"
echo "  2. In the agent: \"Index this project\" (uses index_repository under the hood)"
echo "  3. (Optional) Enable auto-index: codebase-memory-mcp config set auto_index true"
echo "  4. Open UI (if desired): codebase-memory-mcp --ui=true --port=9749"
echo ""
echo "Useful commands:"
echo "  codebase-memory-mcp --help"
echo "  codebase-memory-mcp update"
echo "  codebase-memory-mcp uninstall          # removes agent configs (keeps binary + dbs)"
echo "  codebase-memory-mcp cli list_projects"
echo "  codebase-memory-mcp cli search_graph '{\"label\": \"Function\"}'"
echo ""
echo "See full docs: https://github.com/DeusData/codebase-memory-mcp"
echo ""
