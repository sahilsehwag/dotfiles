#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if F_isMac; then
	source $script_directory/install.mac.sh
else
	F_logError "Java installation is only supported on macOS."
fi
