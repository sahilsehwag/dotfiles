#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/emacs" && return 0 || return 1
