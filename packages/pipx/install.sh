#!/usr/bin/env bash
if F_isMac; then
	brew install pipx
else
	F_pkg_install pipx
fi
pipx ensurepath
