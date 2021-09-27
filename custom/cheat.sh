#!usr/bin/env bash

# dependencies
type bat &> /dev/null || F_install bat

function cheat() {
	if type curl &> /dev/null; then
		if type bat &> /dev/null; then
			curl cheat.sh/$1 | bat
		else
			curl cheat.sh/$1 | cat
		fi
	else
		echo "curl is not installed"
	fi
}
