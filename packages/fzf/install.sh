#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_pkg_install fzf

if ! F_isSoftlink "$HOME/.config/fzf"; then
	ln -sv "$script_directory/" "$HOME/.config/fzf"
fi
