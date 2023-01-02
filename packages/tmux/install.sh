#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

! F_isSoftlink "$HOME/.config/tmux" && ln -sv "$script_directory/"          "$HOME/.config/tmux"
! F_isSoftlink "$HOME/.tmux.conf"   && ln -sv "$script_directory/tmux.conf" "$HOME/.tmux.conf"

sudo cp "$script_directory/bin/tmux-icon-name" /usr/local/bin/tmux-icon-name
sudo chmod +x /usr/local/bin/tmux-icon-name

git clone https://github.com/tmux-plugins/tpm "$HOME/.cache/tmux/plugins/tpm"

F_pkg_install tmux
F_install tmuxinator

if F_isMac; then
	brew tap arl/arl
	brew install gitmux
else
	go install github.com/arl/gitmux@latest
fi
