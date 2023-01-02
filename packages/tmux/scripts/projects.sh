#!/usr/bin/env bash

select_project() {
	tmuxinator list | tail -n+2 | fzf-tmux -p -w60% \
		--bind='ctrl-o:execute(tmuxinator start {})+abort' \
		--bind='ctrl-c:execute(tmuxinator stop {})+abort' \
		--bind='ctrl-d:execute(tmuxinator delete {})+abort' \
		--bind='enter:execute(tmuxinator start {})+abort'
}

open_project() {
	local project="$(select_project)"
	if [[ -n $project ]]; then
		tmuxinator start $project
	fi
}

open_project
