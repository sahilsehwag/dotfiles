#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if ! F_isSoftlink "$HOME/.config/emacs"; then
	ln -sv "$script_directory/" "$HOME/.config/emacs"
fi
if ! F_isSoftlink "$HOME/.emacs.d/init.el"; then
	mkdir -p "$HOME/.emacs.d"
	ln -sv "$script_directory/init.el" "$HOME/.emacs.d/init.el"
fi

if F_isInstalled emacs; then
	sh -x "$script_directory/scripts/install_packages.sh"
fi
