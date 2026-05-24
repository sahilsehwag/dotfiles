#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if ! F_isSoftlink "$HOME/.config/starship.toml"; then
	ln -sv $script_directory/starship.toml $HOME/.config/starship.toml
fi
