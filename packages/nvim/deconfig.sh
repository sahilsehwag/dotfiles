#!/usr/bin/env bash
F_isSoftlink "$HOME/.vimrc"        && rm "$HOME/.vimrc"
F_isSoftlink "$HOME/.vim"          && rm "$HOME/.vim"
F_isSoftlink "$HOME/.config/nvim"  && rm "$HOME/.config/nvim"
