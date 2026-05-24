#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/bat" && return 0 || return 1
