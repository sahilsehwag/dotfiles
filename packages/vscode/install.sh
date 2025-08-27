#!/usr/bin/env bash
brew install visual-studio-code

script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if F_isMac; then
	if ! F_isSoftLink "$HOME/Library/Application Support/Code/User/settings.json"; then
		ln -sv "$HOME/Library/Application Support/Code/User/settings.json" "$script_directory/settings.json"
	fi
	if ! F_isSoftLink "$HOME/Library/Application Support/Code/User/keybindings.json"; then
		ln -sv "$HOME/Library/Application Support/Code/User/keybindings.json" "$script_directory/keybindings.json"
	fi
	if ! F_isSoftLink "$HOME/Library/Application Support/Code/User/extensions.json"; then
		ln -sv "$HOME/Library/Application Support/Code/User/extensions.json" "$script_directory/extensions.json"
	fi
fi

