#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if F_isMac; then
	brew tap alajmo/mani
	brew install mani
fi

if type mani &> /dev/null; then
	mani completion zsh > $script_directory/scripts/init.zsh
	mani completion bash > $script_directory/scripts/init.bash
	mani completion fish > $script_directory/scripts/init.fish
fi
