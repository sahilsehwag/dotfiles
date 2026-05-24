#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
if F_isMac; then
	if ! F_isSoftlink "$HOME/Library/Application Support/lazygit/config.yml"; then
		ln -sv "$script_directory/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
	fi
elif F_isLinux; then
	if ! F_isSoftlink "$HOME/.config/lazygit"; then
		ln -sv "$script_directory/" "$HOME/.config/lazygit"
	fi
fi
