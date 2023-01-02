#!/usr/bin/env bash

select_file() {
	echo "$( \
		fd -tf . $HOME | fzf-tmux -p -w60% \
		--bind='alt-s:execute(tmux new-session -dPc $(dirname {}) zsh | xargs tmux switch-client -t)+abort' \
		--bind='alt-e:execute(tmux new-session -dPc $(dirname {}) "nvim {}" | xargs tmux switch-client -t)+abort' \
		--bind='alt-f:execute(tmux new-session -dPc $(dirname {}) vifm $(dirname {}) | xargs tmux switch-client -t)+abort' \
		--bind='alt-g:execute(tmux new-session -dPc $(dirname {}) lazygit | xargs tmux switch-client -t)+abort' \
		\
		--bind='ctrl-s:execute(tmux new-window -c $(dirname {}) zsh)+abort' \
		--bind='ctrl-e:execute(tmux new-window -c $(dirname {}) "nvim {}")+abort' \
		--bind='ctrl-f:execute(tmux new-window -c $(dirname {}) vifm $(dirname {}))+abort' \
		--bind='ctrl-g:execute(tmux new-window -c $(dirname {}) lazygit)+abort' \
		--bind='ctrl-o:execute(open {})+abort' \
	)"
}

open_file() {
	local file="$(select_file)"
	if [[ -n $file ]]; then
		tmux new-window -c "$file" "nvim ."
	fi
}

open_file
