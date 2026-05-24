#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/broot/conf.hjson" && return 0 || return 1
