#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
if ! F_isSoftlink "$HOME/.config/doom"; then
	ln -sv "$script_directory/dotfiles/" "$HOME/.config/doom"
fi
