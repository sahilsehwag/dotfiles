#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if [[ "$OSTYPE" == "darwin"* ]]; then
	type xplr &> /dev/null || brew install xplr
fi
