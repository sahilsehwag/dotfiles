#!/usr/bin/env sh
if ! F_isInstalled ogit; then
	go install -ldflags="-X main.version=installed-with-go-install" github.com/wmalik/ogit/cmd/ogit@latest
fi
