#!/usr/bin/env bash

F_pipe() {
	local fn="$1"
	local file="$2"
	eval "$fn < ${file:-/dev/stdin}"
}
