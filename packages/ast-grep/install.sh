#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if type yarn &> /dev/null; then
	type package &> /dev/null || yarn global add @ast-grep/cli
elif type npm &> /dev/null; then
	type package &> /dev/null || npm install @ast-grep/cli
elif type go &> /dev/null; then
	type package &> /dev/null || go install package@latest
fi
