#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
if ! F_isSoftlink "$HOME/.config/tmux"; then
	ln -sv "$script_directory/" "$HOME/.config/tmux"
fi
if ! F_isSoftlink "$HOME/.tmux.conf"; then
	ln -sv "$script_directory/tmux.conf" "$HOME/.tmux.conf"
fi
