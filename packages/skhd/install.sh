#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if F_isMac; then
	brew install koekeishiya/formulae/skhd
fi

if F_isInstalled skhd; then
	if ! F_isSoftlink "$HOME/.config/skhd"; then
		ln -sv "$script_directory/" "$HOME/.config/skhd"
	fi
	skhd --start-service
fi
