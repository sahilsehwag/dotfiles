#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/fzf" && return 0 || return 1
