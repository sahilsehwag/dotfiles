#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if F_isMac && F_isInstalled brew; then
	brew install --cask git-credential-manager
else
	echo [install] SKIPPING git-credential-manager (no installer case matched)
fi
