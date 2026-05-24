#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/tmux" && return 0 || return 1
