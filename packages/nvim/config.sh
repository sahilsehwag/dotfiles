#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
if ! F_isSoftlink "$HOME/.config/nvim"; then
	ln -sv "$script_directory/" "$HOME/.config/nvim"
fi
mkdir -p "$HOME/.local/share/nvim/site"
if ! F_isSoftlink "$HOME/.vim"; then
	ln -sv "$HOME/.local/share/nvim/site" "$HOME/.vim"
fi
if ! F_isSoftlink "$HOME/.vimrc"; then
	ln -sv ".config/nvim/init.vim" "$HOME/.vimrc"
fi
