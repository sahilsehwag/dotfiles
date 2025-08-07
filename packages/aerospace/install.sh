#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

brew install --cask nikitabobko/tap/aerospace

if ! F_isSoftlink "$HOME/.config/aerospace"; then
	ln -sv "$script_directory/config/" "$HOME/.config/aerospace"
fi
