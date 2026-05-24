#!/usr/bin/env bash
if F_isMac; then
	brew install broot
else
	F_pkg_install broot
fi
broot
