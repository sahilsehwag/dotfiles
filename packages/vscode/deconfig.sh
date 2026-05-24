#!/usr/bin/env bash
if F_isMac; then
	vscode_user="$HOME/Library/Application Support/Code/User"
	F_isSoftlink "$vscode_user/settings.json"    && rm "$vscode_user/settings.json"
	F_isSoftlink "$vscode_user/keybindings.json" && rm "$vscode_user/keybindings.json"
	F_isSoftlink "$vscode_user/extensions.json"  && rm "$vscode_user/extensions.json"
fi
