#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

# Create config directory and symlink dotfiles if needed
mkdir -p "$HOME/.oh-my-pi"

if [ -d "$script_directory/dotfiles" ] && [ -f "$script_directory/dotfiles/config.json" ]; then
    if ! F_isSoftlink "$HOME/.oh-my-pi/config.json"; then
        ln -sv "$script_directory/dotfiles/config.json" "$HOME/.oh-my-pi/config.json" 2>/dev/null || true
    fi
fi
