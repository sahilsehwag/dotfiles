#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/alacritty" && return 0 || return 1
