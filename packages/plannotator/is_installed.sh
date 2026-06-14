#!/usr/bin/env bash
# Returns 0 if the plannotator binary is available (installed by the official script).
command -v plannotator &> /dev/null && return 0 || return 1
