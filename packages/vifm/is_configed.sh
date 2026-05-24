#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/vifm" && return 0 || return 1
