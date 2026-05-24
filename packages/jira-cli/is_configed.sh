#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/.jira" && return 0 || return 1
