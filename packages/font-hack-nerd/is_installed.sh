#!/usr/bin/env bash

if F_isMac; then
	if [[ $(brew list --cask | grep -E "font-hack-nerd-font" | wc -l) -eq 1 ]]; then
		return 0
	else
		return 1
	fi
else
	return 1
fi
