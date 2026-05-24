#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
if ! F_isSoftlink "$HOME/.config/git"; then
	ln -sv "$script_directory/" "$HOME/.config/git"
fi
if ! F_isSoftlink "$HOME/.gitconfig"; then
	ln -sv "$HOME/.config/git/.gitconfig" "$HOME/.gitconfig"
fi
