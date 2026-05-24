#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/starship.toml" && return 0 || return 1
