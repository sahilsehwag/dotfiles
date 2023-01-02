#!/usr/bin/env bash

select_directory() {
	echo "$( \
		fasd -dlR | fzf-tmux -p -w60% \
		--bind='alt-s:execute(tmux new-session -dPc {} zsh | xargs tmux switch-client -t)+abort' \
		--bind='alt-e:execute(tmux new-session -dPc {} "nvim ." | xargs tmux switch-client -t)+abort' \
		--bind='alt-f:execute(tmux new-session -dPPc {} vifm | xargs tmux switch-client -t)+abort' \
		--bind='alt-g:execute(tmux new-session -dPc {} lazygit | xargs tmux switch-client -t)+abort' \
		\
		--bind='ctrl-s:execute(tmux new-window -c {} zsh)+abort' \
		--bind='ctrl-e:execute(tmux new-window -c {} "nvim .")+abort' \
		--bind='ctrl-f:execute(tmux new-window -c {} vifm)+abort' \
		--bind='ctrl-g:execute(tmux new-window -c {} lazygit)+abort' \
		--bind='ctrl-o:execute(open {})+abort' \
	)"
}

open_directory() {
	local dir="$(select_directory)"
	if [[ -n $dir ]]; then
		tmux new-window -c "$dir" "nvim ."
	fi
}

open_directory
