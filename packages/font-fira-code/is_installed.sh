#!/usr/bin/env bash

if F_isMac; then
	if [[ $(brew list --cask | grep -E "font-fira-code|font-fira-code-nerd-font" | wc -l) -eq 2 ]]; then
		return 0
	else
		return 1
	fi
else
	return 1
fi
