#!/usr/bin/env bash

select_window() {
	tmux list-windows -aF "(#S)<=>#W" | column -ts "<=>" | fzf-tmux -p -w60% \
		--bind='enter:execute(tmux select-window -t $(echo {} | awk "{$1=\"\"; print $0}")+abort' \
		--bind='ctrl-x:execute(tmux unlink-window -kt $(echo {} | awk "{$1=\"\"; print $0}")+abort'
}

open_window() {
	local window=$(select_window)
}

open_window
