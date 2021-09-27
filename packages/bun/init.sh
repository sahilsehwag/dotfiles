#!/usr/bin/env bash

# bun completions
[ -s "/Users/sahilsehwag/.bun/_bun" ] && source "/Users/sahilsehwag/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
