#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/kitty" && return 0 || return 1
