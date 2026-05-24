#!/usr/bin/env bash
F_isDir $DOTFILES_REPOS/neovide || git clone https://github.com/Kethku/neovide $DOTFILES_REPOS/neovide
cd $DOTFILES_REPOS/neovide && git pull

rustup-init
cargo build --release
cp ./target/release/neovide /usr/local/bin/neovide
