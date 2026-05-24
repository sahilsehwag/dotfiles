#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/nvim" && return 0 || return 1
