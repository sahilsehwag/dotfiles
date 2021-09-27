#!/usr/bin/env bash

F_match() {
	local pattern="$1"
	local text="$2"

	eval "echo \"$text\" | rg \"$pattern\""
}

F_replace() {
	local pattern="$1"
	local text="$2"

	eval "echo \"$text\" | sed -e \"s/$pattern/$3/g\""
}
