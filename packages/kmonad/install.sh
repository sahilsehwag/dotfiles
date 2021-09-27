#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -L ~/.config/kmonad ]] && ln -sv $script_directory/ ~/.config/kmonad

if [[ "$OSTYPE" == "darwin"* ]]; then
	source $script_directory/scripts/install.mac.sh
fi
