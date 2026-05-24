#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if F_isMac; then
	brew install --cask git-credential-manager
fi
