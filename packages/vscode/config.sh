#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
if F_isMac; then
	vscode_user="$HOME/Library/Application Support/Code/User"
	if ! F_isSoftlink "$vscode_user/settings.json"; then
		ln -sv "$script_directory/settings.json" "$vscode_user/settings.json"
	fi
	if ! F_isSoftlink "$vscode_user/keybindings.json"; then
		ln -sv "$script_directory/keybindings.json" "$vscode_user/keybindings.json"
	fi
	if ! F_isSoftlink "$vscode_user/extensions.json"; then
		ln -sv "$script_directory/extensions.json" "$vscode_user/extensions.json"
	fi
fi
