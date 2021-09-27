#!/usr/bin/env bash
F_module() {
	if ! cat $HOME/.cache/modules | grep -i "$1" &> /dev/null; then
		echo "$1 $2" >> $HOME/.cache/modules
	fi
}

F_import() {
	source $(cat $HOME/.cache/modules | rg -i "$1" | awk '{print $2}')
}
