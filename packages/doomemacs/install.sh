#!/usr/bin/env bash
F_install emacs

script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})
F_isSoftlink ~/.config/doom || ln -sv $script_directory/dotfiles/ ~/.config/doom

F_isDir ~/.emacs.d && rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
