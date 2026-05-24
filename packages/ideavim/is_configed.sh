#!/usr/bin/env bash
F_isSoftlink "$HOME/.ideavimrc" && return 0 || return 1
