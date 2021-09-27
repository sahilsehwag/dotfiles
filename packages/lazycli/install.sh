#!/usr/bin/env bash

if F_isInstalled cargo; then
	cargo install --locked lazycli
else
	F_pkg_install lazycli
fi

if ! F_isInstalled lazycli; then
	F_isDir $SCRIPTS_REPOS/lazycli || git clone https://github.com/jesseduffield/lazycli.git $SCRIPTS_REPOS/lazycli
	cd $SCRIPTS_REPOS/lazycli && git pull
	cargo install --locked --path .
fi

