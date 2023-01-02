#!/usr/bin/env bash
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	platform='linux'
elif [[ "$OSTYPE" == "freebsd"* ]]; then
	platform='freebsd'
elif [[ "$OSTYPE" == "darwin"* ]]; then
	platform='mac'
elif [[ "$OSTYPE" == "cygwin" ]]; then
	platform='windows.cygwin'
elif [[ "$OSTYPE" == "msys" ]]; then
	platform='windows.mingw'
elif [[ "$OSTYPE" == "win32" ]]; then
	platform='windows'
else
	platform=''
fi
