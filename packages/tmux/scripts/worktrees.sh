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
	git -C "$(get_root)" branch -a --no-color \
		| grep -v HEAD \
		| grep -v ' -> ' \
		| sed 's/^\*\s*//' \
		| sed 's/^\s*//' \
		| sed 's/[[:space:]]*$//' \
		| sed 's|remotes/origin/||' \
		| sort -u
}

list_local_branches() {
	git -C "$(get_root)" branch --no-color \
		| grep -v HEAD \
		| sed 's/^\*\s*//' \
		| sed 's/^\s*//' \
		| sed 's/[[:space:]]*$//' \
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

available_local_branches() {
	local wt_branches
	wt_branches="$(list_worktree_branches)"
	list_local_branches | while read -r branch; do
		echo "$wt_branches" | grep -qxF "$branch" || echo "$branch"
	done
}

case "$1" in
	add)
		branch="$(available_branches | fzf --prompt "Checkout branch: ")" || exit 0
		[[ -z "$branch" ]] && exit 0
		root="$(get_root)"
		repo="$(get_repo)"
		dest="$root/../worktrees/$repo/$branch"
		mkdir -p "$root/../worktrees/$repo"
		tmux new-window -n "wt:$branch" \
			"bash -c 'cd \"$root\" && git worktree add \"$dest\" \"$branch\"'"
		;;

	add-local)
		branch="$(available_local_branches | fzf --prompt "Checkout branch (local): ")" || exit 0
		[[ -z "$branch" ]] && exit 0
		root="$(get_root)"
		repo="$(get_repo)"
		dest="$root/../worktrees/$repo/$branch"
		mkdir -p "$root/../worktrees/$repo"
		tmux new-window -n "wt:$branch" \
			"bash -c 'cd \"$root\" && git worktree add \"$dest\" \"$branch\"'"
		;;

	add-name)
		branch="$(list_branches | fzf --prompt "Base branch: ")" || exit 0
		branch="$(echo "$branch" | xargs)"
		[[ -z "$branch" ]] && exit 0
		name="$(echo | fzf --print-query --no-sort --prompt "Worktree name: " | head -1)"
		[[ -z "$name" ]] && exit 0
		root="$(get_root)"
		repo="$(get_repo)"
		dest="$root/../worktrees/$repo/$name"
		mkdir -p "$root/../worktrees/$repo"
		tmux new-window -n "wt:$name" \
			"bash -c 'cd \"$root\" && git worktree add -b \"$name\" \"$dest\" \"$branch\"'"
		;;

	add-name-local)
		branch="$(list_local_branches | fzf --prompt "Base branch (local): ")" || exit 0
		branch="$(echo "$branch" | xargs)"
		[[ -z "$branch" ]] && exit 0
		name="$(echo | fzf --print-query --no-sort --prompt "Worktree name: " | head -1)"
		[[ -z "$name" ]] && exit 0
		root="$(get_root)"
		repo="$(get_repo)"
		dest="$root/../worktrees/$repo/$name"
		mkdir -p "$root/../worktrees/$repo"
		tmux new-window -n "wt:$name" \
			"bash -c 'cd \"$root\" && git worktree add -b \"$name\" \"$dest\" \"$branch\"'"
		;;

	remove)
		root="$(get_root)"
		worktree="$2"
		name="$(basename "$worktree")"
		tmux new-window -n "rm:$name" \
			"bash -c 'cd \"$root\" && git worktree remove \"$worktree\"'"
		;;

	remove-force)
		root="$(get_root)"
		worktree="$2"
		name="$(basename "$worktree")"
		tmux new-window -n "rm:$name" \
			"bash -c 'cd \"$root\" && git worktree remove --force \"$worktree\"'"
		;;

	open)
		tmux new-window -c "$2"
		;;

	*)
		root="$(get_root)"
		if [[ -z "$root" ]]; then
			tmux display-message "worktrees: '$PANE_PATH' is not a git repository"
			exit 0
		fi
		git -C "$root" worktree list | awk '{print $1}' \
			| fzf-tmux -p -w80% \
				--prompt "Worktrees > " \
				--header "enter:open  ctrl-a:checkout  ctrl-o:checkout(local)  ctrl-n:new-branch  ctrl-l:new-branch(local)  ctrl-x:remove  ctrl-f:force-remove" \
				--bind="enter:execute($SCRIPT open {})+abort" \
				--bind="ctrl-a:execute(PANE_PATH=$PANE_PATH $SCRIPT add)+abort" \
				--bind="ctrl-o:execute(PANE_PATH=$PANE_PATH $SCRIPT add-local)+abort" \
				--bind="ctrl-n:execute(PANE_PATH=$PANE_PATH $SCRIPT add-name)+abort" \
				--bind="ctrl-l:execute(PANE_PATH=$PANE_PATH $SCRIPT add-name-local)+abort" \
				--bind="ctrl-x:execute(PANE_PATH=$PANE_PATH $SCRIPT remove {})+abort" \
				--bind="ctrl-f:execute(PANE_PATH=$PANE_PATH $SCRIPT remove-force {})+abort" \
		|| true
		;;
esac
