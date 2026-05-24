#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if ! F_isSoftlink "$HOME/.config/broot/conf.hjson"; then
	mkdir -p "$HOME/.config/broot"
	ln -sv "$script_directory/conf.hjson" "$HOME/.config/broot/conf.hjson"
fi
