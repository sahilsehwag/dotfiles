#!/usr/bin/env bash
# Returns 0 when the codebase-memory-mcp binary (installed by official script) is on PATH.
# The upstream installer places a static binary named "codebase-memory-mcp".
command -v codebase-memory-mcp &> /dev/null && return 0 || return 1
