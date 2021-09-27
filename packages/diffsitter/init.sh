#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if [[ $SHELL == "zsh" ]]; then
	source $script_directory/init.sh
elif [[ $SHELL == "bash" ]]; then
	source $script_directory/init.bash
fi
