#!/usr/bin/env bash

function ban() {
	if type bat &> /dev/null; then
		nocorrect man "$@" | bat
	else
		nocorrect man "$@"
	fi
}
