#!/usr/bin/env bash
F_isSoftlink "$HOME/.gitconfig" && rm "$HOME/.gitconfig"
F_isSoftlink "$HOME/.config/git" && rm "$HOME/.config/git"
