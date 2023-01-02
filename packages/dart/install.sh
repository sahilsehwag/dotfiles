#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if [[ "$OSTYPE" == "darwin"* ]]; then
	source $script_directory/install.mac.sh
fi
