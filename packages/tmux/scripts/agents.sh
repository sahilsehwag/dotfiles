#!/usr/bin/env bash
# agents.sh — Claude Code agent sidebar for tmux

SCRIPT="$(realpath "$0")"
_AGENTS_DIR="$(cd "$(dirname "$SCRIPT")" && pwd)"
source "$_AGENTS_DIR/../../../core/libs/require.sh"

CLR_RESET=$'\033[0m'
CLR_WORKING=$'\033[1;33m'
CLR_INPUT=$'\033[1;32m'
CLR_PERM=$'\033[1;31m'
CLR_IDLE=$'\033[2;37m'
CLR_REPO=$'\033[1;36m'
CLR_BRANCH=$'\033[0;34m'
CLR_META=$'\033[2;37m'

detect_status() {
	local pane_id="$1" content
	content=$(tmux capture-pane -pt "$pane_id" -S -20 2>/dev/null) || { echo "idle"; return; }

	if printf '%s' "$content" | grep -qiE 'Do you want|Allow.*\(y/n\)|Deny.*\(y/n\)|\[y/n\]|yes/no|yes\|no'; then
		echo "permission"
	elif printf '%s' "$content" | grep -qE 'esc to interrupt|Thinking\.\.\.|Running\.\.\.|Working\.\.\.'; then
		echo "working"
	elif printf '%s' "$content" | grep -q '[⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏]'; then
		echo "working"
	elif printf '%s' "$content" | tail -2 | grep -qE '^\s*(>|Human:)?\s*$'; then
		echo "input"
	else
		echo "idle"
	fi
}

get_project_info() {
	local path="$1" root main_root repo branch
	root=$(git -C "$path" rev-parse --show-toplevel 2>/dev/null)
	if [[ -z "$root" ]]; then
		printf '%s|' "$(basename "$path")"
		return
	fi
	main_root=$(git -C "$root" worktree list 2>/dev/null | awk 'NR==1{print $1}')
	repo=$(basename "${main_root:-$root}")
	branch=$(git -C "$path" branch --show-current 2>/dev/null)
	printf '%s|%s' "$repo" "$branch"
}

elapsed_str() {
	local start="$1" now elapsed
	[[ -z "$start" || "$start" == "0" ]] && { printf '--'; return; }
	now=$(date +%s)
	elapsed=$(( now - start ))
	if (( elapsed < 60 )); then
		printf '%ds' "$elapsed"
	elif (( elapsed < 3600 )); then
		printf '%dm' "$(( elapsed / 60 ))"
	else
		printf '%dh%dm' "$(( elapsed / 3600 ))" "$(( (elapsed % 3600) / 60 ))"
	fi
}

is_claude_pane() {
	local cmd="$1" pane_pid="$2"
	[[ "$cmd" == *"claude"* ]] && return 0
	# pane_pid is the claude process itself (tmux spawned claude directly)
	printf '%s\n' "$_claude_pids" | grep -qx "$pane_pid" && return 0
	# pane_pid is a shell; claude is running as its child
	printf '%s\n' "$_claude_parent_pids" | grep -qx "$pane_pid"
}

list_agents() {
	_claude_pids=$(pgrep -f "claude" 2>/dev/null || true)
	_claude_parent_pids=""
	if [[ -n "$_claude_pids" ]]; then
		_claude_parent_pids=$(while IFS= read -r pid; do
			ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' '
		done <<< "$_claude_pids" | grep -v '^$' | sort -u)
	fi

	while IFS='|' read -r pane_id cmd pane_pid path start_time session win pane; do
		is_claude_pane "$cmd" "$pane_pid" || continue

		local proj repo branch status elapsed
		proj=$(get_project_info "$path")
		repo="${proj%%|*}"
		branch="${proj##*|}"
		status=$(detect_status "$pane_id")
		elapsed=$(elapsed_str "$start_time")

		repo="${repo:-(no-repo)}"
		branch="${branch:-(detached)}"

		printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
			"$status" "$repo" "$branch" "$session" "$win" "$pane" "$elapsed" "$pane_id"
	done < <(tmux list-panes -a \
		-F '#{pane_id}|#{pane_current_command}|#{pane_pid}|#{pane_current_path}|#{window_activity}|#{session_name}|#{window_index}|#{pane_index}')
}

focus_pane() {
	local pane_id="$1"
	[[ -z "$pane_id" ]] && return 1
	local session win
	session=$(tmux display-message -pt "$pane_id" -F '#{session_name}' 2>/dev/null) || return 1
	win=$(tmux display-message -pt "$pane_id" -F '#{window_id}' 2>/dev/null)
	tmux switch-client -t "$session"
	tmux select-window -t "$win"
	tmux select-pane -t "$pane_id"
}

spawn_agent() {
	local pane_id="${1:-}" path
	if [[ -n "$pane_id" ]]; then
		path=$(tmux display-message -pt "$pane_id" -F '#{pane_current_path}' 2>/dev/null)
	fi
	tmux new-window -c "${path:-$HOME}" claude
}

status_count() {
	local cache_file="/tmp/tmux-agents-count"
	local now mtime age

	now=$(date +%s)
	if [[ -f "$cache_file" ]]; then
		mtime=$(stat -f%m "$cache_file" 2>/dev/null || stat -c%Y "$cache_file" 2>/dev/null || echo 0)
		age=$(( now - mtime ))
		if (( age < 3 )); then
			cat "$cache_file"
			return
		fi
	fi

	_claude_pids=$(pgrep -f "claude" 2>/dev/null || true)
	_claude_parent_pids=""
	if [[ -n "$_claude_pids" ]]; then
		_claude_parent_pids=$(while IFS= read -r pid; do
			ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' '
		done <<< "$_claude_pids" | grep -v '^$' | sort -u)
	fi

	local total=0 working=0 input=0 perm=0
	while IFS='|' read -r pane_id cmd pane_pid; do
		is_claude_pane "$cmd" "$pane_pid" || continue
		total=$(( total + 1 ))
		case "$(detect_status "$pane_id")" in
			working)    working=$(( working + 1 )) ;;
			input)      input=$(( input + 1 )) ;;
			permission) perm=$(( perm + 1 )) ;;
		esac
	done < <(tmux list-panes -a -F '#{pane_id}|#{pane_current_command}|#{pane_pid}')

	local out=""
	if (( total > 0 )); then
		out="●${total}"
		(( working > 0 )) && out+=" ⠋${working}"
		(( input > 0 ))   && out+=" ?${input}"
		(( perm > 0 ))    && out+=" !${perm}"
	fi

	printf '%s' "$out" > "$cache_file"
	printf '%s' "$out"
}

run_popup_gum() {
	require gum --no-exit || {
		printf '\n  gum is required for the agent picker. Install it and retry.\n'
		sleep 3
		exit 1
	}

	local raw
	raw=$(list_agents)

	if [[ -z "$raw" ]]; then
		printf '\n  No Claude Code agents running\n'
		sleep 2
		exit 0
	fi

	# First pass: compute max column widths (capped to prevent line overflow)
	local max_repo=4 max_branch=6
	while IFS=$'\t' read -r status repo branch _rest; do
		(( ${#repo}   > max_repo   )) && max_repo=${#repo}
		(( ${#branch} > max_branch )) && max_branch=${#branch}
	done <<< "$raw"
	(( max_repo   > 16 )) && max_repo=16
	(( max_branch > 16 )) && max_branch=16

	# Second pass: build aligned colored lines; pane_id is embedded at the end
	local -a items
	while IFS=$'\t' read -r status repo branch session win pane elapsed pane_id; do
		local icon clr_s abbr
		case "$status" in
			working)    icon="⠋" clr_s="$CLR_WORKING" abbr="work" ;;
			input)      icon="?" clr_s="$CLR_INPUT"   abbr="wait" ;;
			permission) icon="!" clr_s="$CLR_PERM"    abbr="perm" ;;
			*)          icon="✓" clr_s="$CLR_IDLE"    abbr="idle" ;;
		esac

		local r="$repo" b="$branch"
		(( ${#r} > max_repo   )) && r="${r:0:$(( max_repo - 1 ))}~"
		(( ${#b} > max_branch )) && b="${b:0:$(( max_branch - 1 ))}~"

		local loc="${session:0:8}:${win}.${pane}"
		local line
		line="${clr_s}${icon} ${abbr}${CLR_RESET}"
		line+="  ${CLR_REPO}$(printf "%-${max_repo}s" "$r")${CLR_RESET}"
		line+="  ${CLR_BRANCH}$(printf "%-${max_branch}s" "$b")${CLR_RESET}"
		line+="  ${CLR_META}$(printf "%-11s" "$loc")${elapsed}  ${pane_id}${CLR_RESET}"
		items+=("$line")
	done <<< "$raw"

	local selected
	selected=$(printf '%s\n' "${items[@]}" | \
		gum choose \
			--cursor="▸ " \
			--cursor.foreground="75" \
			--height="${#items[@]}" \
			--header="  Claude Agents  ↑↓ navigate · enter focus" \
			--header.foreground="33" \
	) || exit 0

	# Strip ANSI from the selected line then extract the trailing pane_id (%N)
	local pane_id
	pane_id=$(printf '%s' "$selected" | sed $'s/\033\\[[0-9;]*m//g' | grep -oE '%[0-9]+$')
	[[ -n "$pane_id" ]] && focus_pane "$pane_id"
}

run_sidebar() {
	tmux display-popup -w 40% -h 100% -x 0 -y 0 -E \
		"bash '${SCRIPT}' _popup"
}

case "${1:-}" in
	list)    list_agents ;;
	focus)   focus_pane "${2:-}" ;;
	spawn)   spawn_agent "${2:-}" ;;
	count)   status_count ;;
	_popup)  run_popup_gum ;;
	*)       run_sidebar ;;
esac
