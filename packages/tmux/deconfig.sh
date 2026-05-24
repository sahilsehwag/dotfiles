#!/usr/bin/env bash
F_isSoftlink "$HOME/.tmux.conf"    && rm "$HOME/.tmux.conf"
F_isSoftlink "$HOME/.config/tmux"  && rm "$HOME/.config/tmux"
