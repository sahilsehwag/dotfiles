#!/usr/bin/env bash
F_isSoftlink "$HOME/.oh-my-pi/config.json" && return 0 || return 1
