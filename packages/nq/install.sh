#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_isDir $SCRIPTS_REPOS/nq || git clone https://github.com/leahneukirchen/nq.git $SCRIPTS_REPOS/nq

if F_isDir $SCRIPTS_REPOS/nq; then
	cd $SCRIPTS_REPOS/nq
	git pull
	make all && make install
fi
