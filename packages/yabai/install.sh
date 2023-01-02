#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if F_isMac; then
	brew install koekeishiya/formulae/yabai
	F_install YabaiIndicator
	F_install sketchybar
	F_install skhd
fi

# TODO: NEED TO PARTIALLY DISABLE SYSTEM INTEGRATION PROTECTION

if F_isInstalled yabai; then
	if ! F_isSoftlink "$HOME/.config/yabai"; then
		ln -sv "$script_directory/" "$HOME/.config/yabai"
	fi
	find "$HOME/.config/yabai/bin" -type f | xargs chmod +x
	yabai --start-service
fi
