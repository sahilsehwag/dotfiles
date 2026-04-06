#!/usr/bin/env bash

SCRIPT="$(realpath "$0")"
PANE_PATH="${PANE_PATH:-$PWD}"

get_root() {
	# NR==1 always gives the main repo path, works from any worktree
	git -C "$PANE_PATH" worktree list 2>/dev/null | awk 'NR==1{print $1}'
}

get_repo() {
	basename "$(get_root)"
}

list_branches() {
	git -C "$(get_root)" branch -a \
		| grep -v HEAD \
		| sed 's/^\*\s*//' \
		| sed 's/^\s*//' \
		| sed 's|remotes/origin/||' \
		| sort -u
}

list_worktree_branches() {
	git -C "$(get_root)" worktree list 2>/dev/null \
		| awk 'NR>1{gsub(/[\[\]]/, "", $3); print $3}'
}

available_branches() {
	local wt_branches
	wt_branches="$(list_worktree_branches)"
	list_branches | while read -r branch; do
		echo "$wt_branches" | grep -qxF "$branch" || echo "$branch"
	done
}

case "$1" in
	add)
		branch="$(available_branches | fzf --prompt "Checkout branch: " < /dev/tty > /dev/tty)" || exit 0
		[[ -z "$branch" ]] && exit 0
		root="$(get_root)"
		repo="$(get_repo)"
		dest="$root/../worktrees/$repo/$branch"
		mkdir -p "$root/../worktrees/$repo"
		tmux new-window -n "wt:$branch" \
			"bash -c 'cd \"$root\" && git worktree add \"$dest\" \"$branch\" && exit'"
		;;

	add-name)
		# Invoked via `become` so we have the full popup terminal
		branch="$(list_branches | fzf --prompt "Base branch: ")" || exit 0
		[[ -z "$branch" ]] && exit 0
		root="$(get_root)"
		repo="$(get_repo)"
		# Exit the popup (become replaces fzf, so just exit) then show command-prompt
		tmux command-prompt -p "Worktree name:" \
			"run-shell '$SCRIPT add-name-exec $root $repo $branch %1'"
		;;

	add-name-exec)
		root="$2"
		repo="$3"
		branch="$4"
		name="$5"
		[[ -z "$name" ]] && exit 0
		dest="$root/../worktrees/$repo/$name"
		mkdir -p "$root/../worktrees/$repo"
		tmux new-window -n "wt:$name" \
			"bash -c 'cd \"$root\" && git worktree add -b \"$name\" \"$dest\" \"$branch\" && exit'"
		;;

	remove)
		root="$(get_root)"
		cd "$root" && git worktree remove "$2"
		;;

	remove-force)
		root="$(get_root)"
		cd "$root" && git worktree remove --force "$2"
		;;

	open)
		tmux new-window -c "$2"
		;;

	*)
		root="$(get_root)"
		[[ -z "$root" ]] && exit 0
		git -C "$root" worktree list | awk '{print $1}' \
			| fzf-tmux -p -w80% \
				--prompt "Worktrees > " \
				--header "enter:open  ctrl-a:checkout  ctrl-n:new-branch  ctrl-x:remove  ctrl-f:force-remove" \
				--bind="enter:execute($SCRIPT open {})+abort" \
				--bind="ctrl-a:execute(PANE_PATH=$PANE_PATH $SCRIPT add)+abort" \
				--bind="ctrl-n:become(PANE_PATH=$PANE_PATH $SCRIPT add-name)" \
				--bind="ctrl-x:execute(PANE_PATH=$PANE_PATH $SCRIPT remove {})+abort" \
				--bind="ctrl-f:execute(PANE_PATH=$PANE_PATH $SCRIPT remove-force {})+abort" \
		|| true
		;;
esac
