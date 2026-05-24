#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/tagrity" && return 0 || return 1
