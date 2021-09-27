#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if type brew &> /dev/null; then
	type erdtree &> /dev/null || brew tap solidiquis/tap ; brew install erdtree
elif type cargo &> /dev/null; then
	type erdtree &> /dev/null || cargo install --git https://github.com/solidiquis/erdtree
fi
