#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_isInstalled emacs || F_pkg_install emacs-plus
F_isInstalled emacs || F_pkg_install emacs

if F_isInstalled emacs
then
	F_isSymlink ~/.config/emacs || ln -sv $script_directory/ ~/.config/emacs
	F_isSymlink ~/.emacs.d/init.el || mkdir -p ~/.emacs.d && ln -sv $script_directory/init.el ~/.emacs.d/init.el
	sh -x $script_directory/scripts/install_packages.sh
fi
