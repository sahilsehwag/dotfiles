#!/usr/bin/env bash
if F_isInstalled brew; then
	brew install ms-jpq/sad/sad
elif F_isInstalled cargo; then
	cargo install --locked --all-features --git https://github.com/ms-jpq/sad --branch senpai
else
	F_pkg_install sad
fi
