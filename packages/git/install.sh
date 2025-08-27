#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

#DEPENDENCIES
F_install delta

F_pkg_install git

if ! F_isSoftlink "$HOME/.config/git"; then
	ln -sv "$script_directory/" "$HOME/.config/git"
fi

ln -sv $HOME/.config/git/.gitconfig $HOME/.gitconfig

#EXTENSIONS
F_install gh glab mani git-workspace
