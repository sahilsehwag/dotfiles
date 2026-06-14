#!/usr/bin/env bash

echo "Installing plannotator via the official installer..."
echo "  This installs the plannotator binary and auto-detects/configures hooks, skills, and slash commands for your agents (Claude Code, OpenCode, Cursor, Pi, etc.)."

curl -fsSL https://plannotator.ai/install.sh | bash

echo ""
echo "✓ plannotator installed successfully."
echo ""
echo "Important next steps (from the official README and docs):"
echo "  - Claude Code: /plugin marketplace add backnotprop/plannotator, then /plugin install plannotator@plannotator. Restart Claude Code."
echo "  - OpenCode: Add the plugin to opencode.json."
echo "  - Other agents (Codex, Gemini CLI, Copilot CLI, etc.): The installer usually handles hooks/skills automatically."
echo "  - Full agent-specific instructions: https://plannotator.ai/docs/getting-started/installation/"
echo ""
echo "Try in your agent:"
echo "  /plannotator-review"
echo "  /plannotator-annotate README.md"
echo "  /plannotator-last"
echo ""
echo "CLI usage:"
echo "  plannotator sessions"
echo "  plannotator sessions --open 1"
echo ""
echo "See also the VS Code extension and sharing features at https://plannotator.ai/"
echo ""
