#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -L ~/.tmux.conf ]] && ln -sv $script_directory/dotfiles/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

F_pkg_install.sh tmux
F_install.sh tmuxinator
