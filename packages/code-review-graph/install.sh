#!/usr/bin/env bash

F_install python

if F_installed pipx; then
	pipx install code-review-graph
elif F_isInstalled pip3; then
	pip3 install code-review-graph                     # or: pipx install code-review-graph
elif F_isInstalled pip; then
	pip install code-review-graph                     # or: pipx install code-review-graph
elif ! F_isInstalled pip3; then
	F_install pip3
	pip3 install code-review-graph                     # or: pipx install code-review-graph
elif ! F_isInstalled pip; then
	F_install pip
	pip install code-review-graph                     # or: pipx install code-review-graph
fi

code-review-graph install          # auto-detects and configures all supported platforms
