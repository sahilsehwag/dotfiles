#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
if ! F_isSoftlink "$HOME/.config/zsh"; then
	ln -sv "$script_directory/" "$HOME/.config/zsh"
fi
if ! F_isSoftlink "$HOME/.zshrc"; then
	ln -sv "$script_directory/.zshrc" "$HOME/.zshrc"
fi
if ! F_isSoftlink "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/configs"; then
	ln -sv "$script_directory/plugins" "${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/configs"
fi
chsh -s "$(which zsh)"
touch "$HOME/.tokens"
