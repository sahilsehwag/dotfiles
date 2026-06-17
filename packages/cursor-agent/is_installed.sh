#!/usr/bin/env bash
# Cursor CLI installs the 'agent' binary
command -v agent &> /dev/null && return 0 || return 1
