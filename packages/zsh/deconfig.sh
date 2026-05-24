#!/usr/bin/env bash
F_isSoftlink "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/configs" && rm "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/configs"
F_isSoftlink "$HOME/.zshrc"        && rm "$HOME/.zshrc"
F_isSoftlink "$HOME/.config/zsh"   && rm "$HOME/.config/zsh"
