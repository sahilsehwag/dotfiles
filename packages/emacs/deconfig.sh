#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/emacs" && rm "$HOME/.config/emacs"
F_isSoftlink "$HOME/.emacs.d/init.el" && rm "$HOME/.emacs.d/init.el"
