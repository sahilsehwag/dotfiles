#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/vifm" && [[ -d "$HOME/.config/vifm/vifm_devicons" ]] && return 0 || return 1
