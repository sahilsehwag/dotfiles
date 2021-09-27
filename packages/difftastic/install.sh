#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if ! type difft > /dev/null 2>&1; then
	if type brew &> /dev/null; then
		brew install difftastic
	elif type cargo &> /dev/null; then
		cargo install difftastic
	else
		F_pkg_install difftastic
	fi
fi

if type difft &> /dev/null; then
	difftastic gen-completion bash > $script_directory/init.bash
	difftastic gen-completion zsh > $script_directory/init.zsh
	difftastic gen-completion fish > $script_directory/init.fsh
fi
