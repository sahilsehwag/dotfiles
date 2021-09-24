#!usr/bin/env bash
brew list rustup-init || brew install rustup-init
type rustup-init &> /dev/null && rustup-init
brew list cmake || brew install cmake
