#!/usr/bin/env bash

if F_isMac; then
	brew tap homebrew/cask-fonts
	brew install --cask font-hack-nerd-font
else
	echo "font-hack-nerd only setup for MAC"
fi
