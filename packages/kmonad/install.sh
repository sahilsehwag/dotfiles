#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if ! F_isSoftlink "$HOME/.config/kmonad"; then
	ln -sv "$script_directory/" "$HOME/.config/kmonad"
fi

if F_isMac; then
	source $script_directory/scripts/install.mac.sh
fi
