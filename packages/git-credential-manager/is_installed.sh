#!/usr/bin/env bash

if type git-credential-manager >/dev/null 2>&1; then
	exit 0
else
	exit 1
fi
