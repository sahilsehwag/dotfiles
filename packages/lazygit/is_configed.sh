#!/usr/bin/env bash
if F_isMac; then
	F_isSoftlink "$HOME/Library/Application Support/lazygit/config.yml" && return 0 || return 1
else
	F_isSoftlink "$HOME/.config/lazygit" && return 0 || return 1
fi
