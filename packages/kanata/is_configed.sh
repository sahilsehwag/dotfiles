#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/kanata" && return 0 || return 1
