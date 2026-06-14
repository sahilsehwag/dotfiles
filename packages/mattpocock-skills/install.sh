#!/usr/bin/env bash

echo "Installing mattpocock/skills via the official skills CLI..."
echo "  This will add all skills globally for all supported agents (Claude Code, Cursor, etc)."
echo "  Using --all -g -y for non-interactive global install."

npx --registry=https://registry.npmjs.org --yes skills@latest add mattpocock/skills -g --all

echo ""
echo "✓ mattpocock/skills installed successfully."
echo ""
echo "Important next step (from the skills README):"
echo "  Run /setup-matt-pocock-skills inside your coding agent (Claude Code / Cursor / etc)."
echo "  It will ask for your issue tracker preference (GitHub/Linear/local), triage labels, and docs location."
echo ""
echo "Manage skills later with:"
echo "  npx --yes skills@latest list -g"
echo "  npx --yes skills@latest remove <skill>"
echo ""
