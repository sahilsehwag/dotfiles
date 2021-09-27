#!/usr/bin/env sh
if ! F_isInstalled gitty; then
	go install https://github.com/muesli/gitty.git@latest
fi
if ! F_isInstalled gitty; then
	F_isDir $SCRIPTS_REPOS/gitty || git clone https://github.com/muesli/gitty.git $SCRIPTS_REPOS/gitty
	cd $SCRIPTS_REPOS/gitty
	go build
fi
