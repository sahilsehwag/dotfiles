#!/usr/bin/env bash

select_cmd() {
	echo "$( \
		history | fzf-tmux -p -w60% \
		--bind='ctrl-s:execute(tmux new-window -c {} zsh)+abort' \
		--bind='ctrl-v:execute(tmux new-window -c {} "nvim .")+abort' \
		--bind='ctrl-w:execute(tmux new-window -c #{pane_current_path} {})+abort' \
		--bind='ctrl-t:execute(tmux new-window -c {} lazygit)+abort' \
	)"
}

open_cmd() {
	local cmd="$(select_cmd)"
	#if [[ -n $cmd ]]; then
	#  tmux new-window -c "$cmd" "nvim ."
	#fi
}

open_cmd
