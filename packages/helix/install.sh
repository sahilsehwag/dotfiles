#!/usr/bin/env bash

if F_isInstalled brew; then
	brew tap helix-editor/helix
	brew install helix
elif F_isInstalled dnf; then
	sudo dnf copr enable varlad/helix
	sudo dnf install helix
else
	F_pkg_install helix
fi

if ! F_isInstalled hx; then
	F_isDir $DOTFILES_REPOS/helix || git clone https://github.com/helix-editor/helix $DOTFILES_REPOS/helix
	cd $DOTFILES_REPOS/helix && git pull
	cargo install --path helix-term
fi
