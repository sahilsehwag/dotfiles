#!/usr/bin/env bash
F_isSoftlink "$HOME/.ctags" && return 0 || return 1
