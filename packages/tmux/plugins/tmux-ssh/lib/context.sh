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

# Walk the process tree under a pid and print the first ssh destination.
# Handles PEX-wrapped ssh (bash .../ssh <dest>) and plain /usr/bin/ssh <dest>.
# Skips proxy hops (destinations containing "proxy") and option flags.
_tsh_ssh_dest_from_pid() {
	local root="$1"
	ps -o pid,ppid,command -ax 2>/dev/null | awk -v root="$root" '
		{
			ppid[$1] = $2
			line = ""
			for (i = 3; i <= NF; i++) line = line $i " "
			cmd[$1] = line
		}
		END {
			# BFS from root pid
			n = 1; q[1] = root; seen[root] = 1
			while (idx++ < n) {
				pid = q[idx]
				c = cmd[pid]
				# Match an ssh invocation (wrapped or direct)
				if (c ~ /(^|\/| )ssh /) {
					# Tokenize; find first bareword after "ssh" that is not a flag,
					# not a flag value, and not a proxy hop.
					nt = split(c, t, /[ \t]+/)
					for (i = 1; i <= nt; i++) {
						if (t[i] ~ /(^|\/)ssh$/) {
							for (j = i + 1; j <= nt; j++) {
								tok = t[j]
								if (tok == "") continue
								if (tok ~ /^-/) {
									# option; skip its value for flags that take one
									if (tok ~ /^-[bcDEeFIiLlmOoPpQRSWw]$/) j++
									continue
								}
								if (tok ~ /proxy/) continue          # skip proxy hop
								if (tok ~ /^-W$/) { j++; continue }
								print tok
								exit
							}
						}
					}
				}
				for (p in ppid) if (ppid[p] == pid && !(p in seen)) { seen[p] = 1; q[++n] = p }
			}
		}'
}

_tsh_detect_context() {
	# ── Phase 1: explicit window vars (set by ssh-attach / devpods.sh) ──
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

	# ── Phase 2: auto-detect the ssh destination from the pane process tree ──
	# Works even with PEX-wrapped ssh and after the pane title changes.
	local pane_pid
	pane_pid=$(tmux display-message -p '#{pane_pid}')
	if [ -n "$pane_pid" ]; then
		TSH_HOST=$(_tsh_ssh_dest_from_pid "$pane_pid")
	fi

	# Fallback: parse "user@host" out of the pane title.
	if [ -z "$TSH_HOST" ]; then
		local pane_cmd pane_title
		pane_cmd=$(tmux display-message -p '#{pane_current_command}')
		if [ "$pane_cmd" = "ssh" ]; then
			pane_title=$(tmux display-message -p '#{pane_title}')
			TSH_HOST=$(echo "$pane_title" | grep -oE '@[a-zA-Z0-9._-]+' | tr -d '@' | head -1)
		fi
	fi

	# Auto-detected sessions: remote dir + tmux state are unknown here.
	# tmux-portal resolves the remote cwd via a live probe at keypress.
	TSH_DIR=""
	TSH_HAS_TMUX=""
}

_tsh_detect_context
