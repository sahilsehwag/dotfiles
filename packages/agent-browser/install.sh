#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

# Install via package manager first
F_pkg_install agent-browser

# Run setup script to initialize Chrome and LLM tools
if [ -f "$script_directory/setup.sh" ]; then
    bash "$script_directory/setup.sh"
fi
