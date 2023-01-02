#!/usr/bin/env bash
type brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# linking
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"
