#!/usr/bin/env bash
F_isSoftlink "$HOME/.config/sketchybar" && rm "$HOME/.config/sketchybar"
brew services stop sketchybar
