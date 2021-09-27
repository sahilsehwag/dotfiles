#!/usr/bin/env bash
if F_isInstalled delta; then
	export GIT_PAGER='delta'
elif F_isInstalled bat; then
	export GIT_PAGER='bat'
elif F_isInstalled highlight; then
	export GIT_PAGER='highlight'
fi
