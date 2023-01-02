#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_isDir $DOTFILES_REPOS/nq || git clone https://github.com/leahneukirchen/nq.git $DOTFILES_REPOS/nq

if F_isDir $DOTFILES_REPOS/nq; then
	cd $DOTFILES_REPOS/nq
	git pull
	make all && make install
fi
