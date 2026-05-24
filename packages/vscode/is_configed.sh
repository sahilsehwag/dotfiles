#!/usr/bin/env bash
F_isSoftlink "$HOME/Library/Application Support/Code/User/settings.json" && return 0 || return 1
