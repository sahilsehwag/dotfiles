#!/usr/bin/env sh
if ! F_isInstalled gitty; then
	go install https://github.com/muesli/gitty.git@latest
fi
if ! F_isInstalled gitty; then
	F_isDir $DOTFILES_REPOS/gitty || git clone https://github.com/muesli/gitty.git $DOTFILES_REPOS/gitty
	cd $DOTFILES_REPOS/gitty
	go build
fi
