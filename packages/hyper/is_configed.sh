#!/usr/bin/env bash
F_isSoftlink "$HOME/.hyper.js" && return 0 || return 1
