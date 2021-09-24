#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh -x $script_directory/build.mac.sh
fi

[[ ! -d ~/.sources/neovide ]] && git clone https://github.com/Kethku/neovide ~/.sources/neovide
cd ~/.sources/neovide

if type cargo &> /dev/null; then
	cargo build --release
	cp ./target/release/neovide /usr/local/bin/neovide
fi
