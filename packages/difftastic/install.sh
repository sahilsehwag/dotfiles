#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if ! F_isInstalled difft; then
	if F_isInstalled brew; then
		brew install difftastic
	elif F_isInstalled cargo; then
		cargo install difftastic
	else
		F_pkg_install difftastic
	fi
fi

if F_isInstalled difft; then
	difftastic gen-completion bash > $script_directory/init.bash
	difftastic gen-completion zsh  > $script_directory/init.zsh
	difftastic gen-completion fish > $script_directory/init.fsh
fi
