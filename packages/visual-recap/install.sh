#!/usr/bin/env bash

echo "Installing visual-recap skill via @agent-native/skills CLI (local-files mode)..."
echo "  Running: npx --registry=https://registry.npmjs.org --yes @agent-native/skills@latest add --skill visual-recap --mode local-files"

npx --registry=https://registry.npmjs.org --yes @agent-native/skills@latest add --skill visual-recap --mode local-files || echo "Note: npx add may have warnings (e.g. internal registry); check output above."

echo ""
echo "✓ visual-recap skill add attempted."
echo ""
echo "The skill should now be available in your agent (check .claude/skills/ or equivalent for local-files)."
echo "Use: /visual-recap"
echo ""
echo "To manage: npx @agent-native/skills@latest list"
echo ""
