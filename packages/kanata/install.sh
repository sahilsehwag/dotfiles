#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if F_isMac; then
	! type kanata &> /dev/null && cargo install kanata
else
	echo "[install] NOT_SUPPORTED for non-mac"
fi
