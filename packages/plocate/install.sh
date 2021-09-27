#!/usr/bin/env bash

if ! type plocate &> /dev/null; then
	F_pkg_install plocate
fi

if ! type plocate &> /dev/null; then
	curl https://plocate.sesse.net/download/plocate-1.1.15.tar.gz -o ~/Downloads/plocate.tar.gz
	tar -xf ~/Downloads/plocate.tar.gz -C ~/Downloads/
	cp ~/Downloads/plocate-1.1.15/plocate /usr/local/bin/
fi
