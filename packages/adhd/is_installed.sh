#!/usr/bin/env bash

# Returns 0 if the UditAkhourii/adhd skill appears to be installed globally.
# Checks common agent skill directories for the signature "adhd" skill,
# and falls back to querying via the skills CLI if needed.

signature="adhd"

check_path() {
  local p="$1"
  if [ -d "$p" ] || [ -f "$p/SKILL.md" ]; then
    return 0
  fi
  return 1
}

# Check common global skill locations used by agents + the skills tool
if check_path "$HOME/.claude/skills/$signature" || \
   check_path "$HOME/.cursor/skills/$signature" || \
   check_path "$HOME/.codeium/windsurf/skills/$signature" || \
   check_path "$HOME/.gemini/skills/$signature" || \
   check_path "$HOME/.codex/skills/$signature"; then
  return 0
fi

# Fallback to skills CLI list (quiet, uses public registry to avoid corporate npm issues)
if command -v npx >/dev/null 2>&1; then
  if npx --registry=https://registry.npmjs.org --yes skills@latest list -g --json 2>/dev/null | grep -qi 'adhd'; then
    return 0
  fi
fi

return 1
