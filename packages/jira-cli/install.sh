#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if F_isMac; then
	brew tap ankitpokhrel/jira-cli
	brew install jira-cli
else
	F_pkg_install jira-cli
fi

F_isSymlink ~/.config/.jira || ln -sv $script_directory/ ~/.config/.jira
