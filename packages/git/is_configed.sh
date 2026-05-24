#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/git" && return 0 || return 1
