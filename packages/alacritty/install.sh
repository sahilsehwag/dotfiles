#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_pkg_install alacritty
if ! F_isSoftlink "$HOME/.config/alacritty"; then
	ln -sv $script_directory/ $HOME/.config/alacritty
fi
