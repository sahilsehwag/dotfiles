#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_isInstalled emacs || F_pkg_install emacs-plus
F_isInstalled emacs || F_pkg_install emacs

