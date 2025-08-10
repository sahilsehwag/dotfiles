#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if type brew &> /dev/null; then
	brew install ast-grep
elif type yarn &> /dev/null; then
	type package &> /dev/null || yarn global add @ast-grep/cli
elif type npm &> /dev/null; then
	type package &> /dev/null || npm install --global @ast-grep/cli
elif type go &> /dev/null; then
	type package &> /dev/null || go install package@latest
elif type cargo &> /dev/null; then
	type package &> /dev/null || cargo binstall ast-grep
elif type pip &> /dev/null; then
	type package &> /dev/null || pip install ast-grep-cli
else
	F_log "No supported package manager found. Please install @ast-grep/cli manually."
fi
