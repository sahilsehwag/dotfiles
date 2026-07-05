# lib/context.sh
# Resolves SSH context for the current tmux window.
# Sourced by tmux-ssh, tmux-relay, and tmux-portal.
#
# Exports:
#   TSH_HOST      — SSH hostname (empty = local)
#   TSH_DIR       — remote working directory (may be empty)
#   TSH_HAS_TMUX  — "1" if remote tmux is running

TSH_HOST=""
TSH_DIR=""
TSH_HAS_TMUX=""

_tsh_detect_context() {
	# ── Phase 1: explicit window vars (set by ssh-attach) ──────────
	local host dir has_tmux
	host=$(tmux show-window-options -v @ssh_host 2>/dev/null)
	dir=$(tmux show-window-options -v @ssh_dir 2>/dev/null)
	has_tmux=$(tmux show-window-options -v @ssh_tmux 2>/dev/null)

	if [ -n "$host" ]; then
		TSH_HOST="$host"
		TSH_DIR="$dir"
		TSH_HAS_TMUX="$has_tmux"
		return
	fi

	# ── Phase 2: auto-detect from pane (fallback) ──────────────────
	local pane_cmd
	pane_cmd=$(tmux display-message -p '#{pane_current_command}')

	# Is the foreground process an SSH session?
	if [ "$pane_cmd" = "ssh" ]; then
		# Extract hostname from pane title (often "user@host" when SSH'd in)
		local pane_title
		pane_title=$(tmux display-message -p '#{pane_title}')
		TSH_HOST=$(echo "$pane_title" | grep -oE '@[a-zA-Z0-9._-]+' | tr -d '@' | head -1)
		TSH_DIR=""      # can't know remote dir without var
		TSH_HAS_TMUX="" # can't know without explicit flag
	fi
}

_tsh_detect_context
