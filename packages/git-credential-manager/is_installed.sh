#!/usr/bin/env bash

if type git-credential-manager >/dev/null 2>&1; then
	return 0
else
	return 1
fi
