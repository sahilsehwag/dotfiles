#!/usr/bin/env bash
F_isSoftlink "$HOME/.terminfo" || F_isSoftlink "$HOME/xterm-256color-italic.terminfo" && return 0 || return 1
