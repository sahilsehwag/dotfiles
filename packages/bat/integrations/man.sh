#!/usr/bin/env bash

# using "function" bcz zsh making an alias with same name as function
function man() {
	/usr/bin/man "$@" | bat --language=man
}
