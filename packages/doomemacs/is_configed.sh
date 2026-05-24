#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/doom" && return 0 || return 1
