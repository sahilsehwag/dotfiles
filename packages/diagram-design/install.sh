#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

# Install diagram-design skill for all LLM tools
SKILLS_REPO="$HOME/.diagram-design-skills"
git clone https://github.com/cathrynlavery/diagram-design.git "$SKILLS_REPO" 2>/dev/null || git -C "$SKILLS_REPO" pull

if [ -d "$SKILLS_REPO/skills/diagram-design" ]; then
	# Install for Claude Code
	mkdir -p "$HOME/.claude/skills"
	ln -sf "$SKILLS_REPO/skills/diagram-design" "$HOME/.claude/skills/diagram-design" 2>/dev/null || true

	# Install for Cursor
	mkdir -p "$HOME/.cursor/skills"
	ln -sf "$SKILLS_REPO/skills/diagram-design" "$HOME/.cursor/skills/diagram-design" 2>/dev/null || true

	# Install for Windsurf/Codeium
	mkdir -p "$HOME/.codeium/windsurf/skills"
	ln -sf "$SKILLS_REPO/skills/diagram-design" "$HOME/.codeium/windsurf/skills/diagram-design" 2>/dev/null || true

	# Install for Copilot (if .github exists)
	if [ -d ".github" ]; then
		mkdir -p ".github/skills"
		ln -sf "$SKILLS_REPO/skills/diagram-design" ".github/skills/diagram-design" 2>/dev/null || true
	fi

	# Install for Gemini
	mkdir -p "$HOME/.gemini/skills"
	ln -sf "$SKILLS_REPO/skills/diagram-design" "$HOME/.gemini/skills/diagram-design" 2>/dev/null || true

	# Install for Codex (if available)
	if command -v codex &> /dev/null; then
		mkdir -p "$HOME/.codex/skills"
		ln -sf "$SKILLS_REPO/skills/diagram-design" "$HOME/.codex/skills/diagram-design" 2>/dev/null || true
	fi
fi
