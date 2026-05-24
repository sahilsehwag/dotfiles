#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
if F_isInstalled yabai; then
	if ! F_isSoftlink "$HOME/.config/yabai"; then
		ln -sv "$script_directory/" "$HOME/.config/yabai"
	fi
	find "$HOME/.config/yabai/bin" -type f | xargs chmod +x
	yabai --start-service
fi
