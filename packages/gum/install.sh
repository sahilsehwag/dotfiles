#!/usr/bin/env bash
# https://github.com/charmbracelet/gum — TUI component library for shell scripts

if [[ "$OSTYPE" == "linux"* ]] && command -v apt-get >/dev/null 2>&1; then
	# charmbracelet maintains its own Debian/RPM repo
	if ! command -v gum >/dev/null 2>&1; then
		sudo mkdir -p /etc/apt/keyrings
		curl -fsSL https://repo.charm.sh/apt/gpg.key \
			| sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
		echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
			| sudo tee /etc/apt/sources.list.d/charm.list
		sudo apt-get update -qq
		sudo apt-get install -y gum
	fi
else
	F_pkg_install gum
fi
