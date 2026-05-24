#!/usr/bin/env bash
F_isDir "$HOME/.emacs.d" && rm -rf "$HOME/.emacs.d"
git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.emacs.d"
"$HOME/.emacs.d/bin/doom" install
