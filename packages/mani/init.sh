#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})
if [[ $SHELL =~ "zsh" ]]; then
	# source $script_directory/scripts/init.zsh
elif [[ $SHELL =~ "bash" ]]; then
	source $script_directory/scripts/init.bash
fi
