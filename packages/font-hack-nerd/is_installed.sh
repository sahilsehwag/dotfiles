#!/usr/bin/env bash

if F_isMac; then
	if [[ $(brew list --cask | grep -E "font-hack-nerd-font" | wc -l) -eq 1 ]]; then
		exit 0
	else
		exit 1
	fi
else
	exit 1
fi
