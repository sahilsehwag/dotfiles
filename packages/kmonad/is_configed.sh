#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/kmonad" && return 0 || return 1
