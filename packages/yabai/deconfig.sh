#!/usr/bin/env bash
yabai --stop-service
F_isSoftlink "$HOME/.config/yabai" && rm "$HOME/.config/yabai"
