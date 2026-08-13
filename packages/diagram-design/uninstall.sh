#!/usr/bin/env bash

# Remove the agent skill symlinks created by install.sh, then the cloned repo.
signature="diagram-design"

for dir in \
	"$HOME/.claude/skills" \
	"$HOME/.cursor/skills" \
	"$HOME/.codeium/windsurf/skills" \
	"$HOME/.gemini/skills" \
	"$HOME/.codex/skills" \
	".github/skills"
do
	target="$dir/$signature"
	if [ -L "$target" ]; then
		rm -f "$target"
	fi
done

rm -rf "$HOME/.diagram-design-skills"
