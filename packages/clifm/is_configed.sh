#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/clifm" && return 0 || return 1
