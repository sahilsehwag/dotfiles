#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
sudo cp "$script_directory/bin/tmux-icon-name" /usr/local/bin/tmux-icon-name
sudo chmod +x /usr/local/bin/tmux-icon-name

git clone https://github.com/tmux-plugins/tpm "$HOME/.cache/tmux/plugins/tpm"

F_pkg_install tmux

if F_isMac; then
	brew tap arl/arl
	brew install gitmux
else
	go install github.com/arl/gitmux@latest
fi
