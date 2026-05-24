#!/usr/bin/env bash

if F_isMac; then
	brew install --cask font-fira-code
	brew install --cask font-fira-code-nerd-font
else
	echo "font-fire-code only setup for MAC"
fi
