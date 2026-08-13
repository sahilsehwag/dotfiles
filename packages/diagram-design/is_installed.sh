#!/usr/bin/env bash

# Returns 0 if the diagram-design skill appears to be installed for at least
# one agent (checks the common agent skill directories for the SKILL.md
# signature), falling back to checking the cloned source repo itself.

signature="diagram-design"

check_path() {
  local p="$1"
  if [ -f "$p/SKILL.md" ]; then
    return 0
  fi
  return 1
}

if check_path "$HOME/.claude/skills/$signature" || \
   check_path "$HOME/.cursor/skills/$signature" || \
   check_path "$HOME/.codeium/windsurf/skills/$signature" || \
   check_path "$HOME/.gemini/skills/$signature" || \
   check_path "$HOME/.codex/skills/$signature" || \
   check_path ".github/skills/$signature" ; then
  return 0
fi

# Fallback: the source repo was cloned but no agent symlink exists yet
check_path "$HOME/.diagram-design-skills/skills/diagram-design" && return 0

return 1
