#!/usr/bin/env bash

# Returns 0 if visual-plan skill appears to be installed (local or global).
# Checks common agent skill directories for the skill.

signature="visual-plan"

check_path() {
  local p="$1"
  if [ -d "$p" ] || [ -f "$p/SKILL.md" ]; then
    return 0
  fi
  return 1
}

# Check common global and local skill locations where @agent-native/skills add --mode local-files or global would place SKILL.md
if check_path "$HOME/.claude/skills/$signature" || \
   check_path "$HOME/.claude/skills/visual/$signature" || \
   check_path "$HOME/.cursor/skills/$signature" || \
   check_path "$HOME/.codeium/windsurf/skills/$signature" || \
   check_path "$HOME/.gemini/skills/$signature" || \
   check_path "$HOME/.codex/skills/$signature" || \
   check_path "$HOME/.agents/skills/$signature" || \
   check_path ".claude/skills/$signature" || \
   check_path ".agent-native/skills/$signature" || \
   check_path ".agents/skills/$signature" || \
   check_path "skills/$signature" ; then
  return 0
fi

return 1
