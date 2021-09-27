#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if type go &> /dev/null; then
	type fx &> /dev/null || go install github.com/antonmedv/fx@latest
else
	F_pkg_install fx
fi
