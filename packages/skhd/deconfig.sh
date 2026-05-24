#!/usr/bin/env bash
skhd --stop-service
F_isSoftlink "$HOME/.config/skhd" && rm "$HOME/.config/skhd"
