#!/usr/bin/env bash
F_isInstalled sregx || go install github.com/zyedidia/sregx/cmd/sregx@latest

if ! F_isInstalled sregx
then
	F_isDir $DOTFILES_REPOS/sregx || git clone https://github.com/zyedidia/sregx $DOTFILES_REPOS/sregx
	cd $DOTFILES_REPOS/sregx && git pull
	make install
fi
