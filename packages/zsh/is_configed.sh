#!/usr/bin/env bash
F_isSoftlink "$HOME/.zshrc" && return 0 || return 1
