#!/usr/bin/env bash
F_isSoftlink "$HOME/.agent-browser" && return 0 || return 1
