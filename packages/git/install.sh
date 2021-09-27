#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

#dependencies
F_install delta

[[ ! -L ~/.gitconfig ]] && ln -sv $script_directory/dotfiles/.gitconfig ~/.gitconfig

if [[ "$OSTYPE" == "darwin"* ]]; then
	type git &> /dev/null || brew install git
fi
