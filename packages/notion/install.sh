#!/usr/bin/env bash
if F_isMac; then
	brew list notion || brew install --cask notion
fi
