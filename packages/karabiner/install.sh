#!/usr/bin/env bash

if F_isMac; then
	brew list karabiner-elements || brew install karabiner-elements
fi
