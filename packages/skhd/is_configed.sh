#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/skhd" && return 0 || return 1
