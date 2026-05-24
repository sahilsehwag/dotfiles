#!/usr/bin/env bash
if F_isMac; then
	F_isSoftlink "$HOME/Library/Application Support/lazygit/config.yml" && rm "$HOME/Library/Application Support/lazygit/config.yml"
elif F_isLinux; then
	F_isSoftlink "$HOME/.config/lazygit" && rm "$HOME/.config/lazygit"
fi
