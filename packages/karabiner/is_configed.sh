#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/karabiner" && return 0 || return 1
