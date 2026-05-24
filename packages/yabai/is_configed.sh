#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/yabai" && return 0 || return 1
