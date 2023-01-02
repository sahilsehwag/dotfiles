#!/usr/bin/env bash

select_session() {
	tmux list-sessions -F "#S" | fzf-tmux -p -w60% \
		--bind='enter:execute(tmux attach-session -t {})+abort' \
		--bind='ctrl-x:execute(tmux kill-session -t {})+abort'
}

open_session() {
	local session=$(select_session)
}

open_session
