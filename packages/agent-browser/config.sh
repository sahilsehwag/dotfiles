#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

# Create config directory and symlink if it doesn't exist
if ! F_isSoftlink "$HOME/.agent-browser"; then
    mkdir -p "$HOME/.agent-browser"
    ln -sv "$script_directory/dotfiles/config.json" "$HOME/.agent-browser/config.json" 2>/dev/null || true
fi
