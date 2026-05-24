#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/goneovim" && return 0 || return 1
