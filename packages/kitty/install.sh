#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_pkg_install kitty
if ! F_isSoftlink "$HOME/.config/kitty"; then
	ln -sv $script_directory/ $HOME/.config/kitty
fi
