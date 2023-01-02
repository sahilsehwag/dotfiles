#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if ! type diffsitter > /dev/null 2>&1; then
	if type brew &> /dev/null; then
		brew tap afnanenayet/tap ; brew install diffsitter
	elif type pacman &> /dev/null; then
		pacman -Sy diffsitter-bin
	elif type yay &> /dev/null; then
		yay -Sy diffsitter-bin
	else
		F_pkg_install diffsitter
	fi
fi

if type diffsitter &> /dev/null; then
	diffsitter gen-completion bash > $script_directory/init.bash
	diffsitter gen-completion zsh > $script_directory/init.zsh
	diffsitter gen-completion fish > $script_directory/init.fsh
fi
