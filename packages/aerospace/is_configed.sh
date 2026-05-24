#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/aerospace" && return 0 || return 1
