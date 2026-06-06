#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

# Alias for quick access to agent-browser
alias ab="agent-browser"

# Environment variables for agent-browser LLM integration
export AGENT_BROWSER_HEADLESS=true
export AGENT_BROWSER_TIMEOUT=30000
