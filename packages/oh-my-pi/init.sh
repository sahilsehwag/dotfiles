#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

# oh-my-pi config directory
export OMP_CONFIG_DIR="${OMP_CONFIG_DIR:-$HOME/.oh-my-pi}"

# Model provider environment variables (if configured)
# export OMP_MODEL_PROVIDER="openai"  # or anthropic, etc.
# export OMP_API_KEY="your-key-here"

