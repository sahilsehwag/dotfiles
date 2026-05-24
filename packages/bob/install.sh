#!/usr/bin/env bash
cargo install --git https://github.com/MordechaiHadad/bob.git
#cargo install bob-nvim

bob install nightly
bob install stable
bob install 0.8.0
bob use nightly
