#!/usr/bin/env bash

if [[ -f "$HOME/.local/bin/kmonad" ]]; then
	return 0
else
	return 1
fi
