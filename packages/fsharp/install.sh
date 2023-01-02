#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --version latest
