#!/usr/bin/env bash
F_pkg_install fallow

# Install fallow-skills for all LLM tools
if command -v fallow &> /dev/null; then
	SKILLS_REPO="$HOME/.fallow-skills"
	git clone https://github.com/fallow-rs/fallow-skills.git "$SKILLS_REPO" 2>/dev/null || git -C "$SKILLS_REPO" pull

	# Install for Claude Code
	mkdir -p "$HOME/.claude/skills"
	ln -sf "$SKILLS_REPO/fallow/skills/fallow" "$HOME/.claude/skills/fallow" 2>/dev/null || true

	# Install for Cursor
	mkdir -p "$HOME/.cursor/skills"
	ln -sf "$SKILLS_REPO/fallow/skills/fallow" "$HOME/.cursor/skills/fallow" 2>/dev/null || true

	# Install for Windsurf/Codeium
	mkdir -p "$HOME/.codeium/windsurf/skills"
	ln -sf "$SKILLS_REPO/fallow/skills/fallow" "$HOME/.codeium/windsurf/skills/fallow" 2>/dev/null || true

	# Install for Copilot (if .github exists)
	if [ -d ".github" ]; then
		mkdir -p ".github/skills"
		ln -sf "$SKILLS_REPO/fallow/skills/fallow" ".github/skills/fallow" 2>/dev/null || true
	fi

	# Install for Gemini
	mkdir -p "$HOME/.gemini/skills"
	ln -sf "$SKILLS_REPO/fallow/skills/fallow" "$HOME/.gemini/skills/fallow" 2>/dev/null || true

	# Install for Codex (if available)
	if command -v codex &> /dev/null; then
		mkdir -p "$HOME/.codex/skills"
		ln -sf "$SKILLS_REPO/fallow/skills/fallow" "$HOME/.codex/skills/fallow" 2>/dev/null || true
	fi
fi
