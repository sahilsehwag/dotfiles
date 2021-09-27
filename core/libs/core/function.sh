#!/usr/bin/env bash

F_call() {
	local fn="$1"
	shift
	local args="$@"
	eval "$fn" "$args"
}

F_map() {
	local fn="$1"
	local file="$2"

	while read line; do
		eval "$fn \"$line\""
	done < "${file:-/dev/stdin}"
}

F_filter() {
	local fn="$1"
	local file="$2"

	while read line; do
		if eval "$fn $line"; then
			echo "$line"
		fi
	done < "${file:-/dev/stdin}"
}

F_reduce() {
	local fn="$1"
	local file="$2"
	local accumulator="$3"

	while read line; do
		eval "$accumulator=\"\$$fn \$$accumulator \$line\""
	done < "${file:-/dev/stdin}"

	eval "$accumulator=\"\$$fn \$$accumulator\""
}

F_foreach() {
	local fn="$1"
	local file="$2"

	while read line; do
		eval "$fn $line"
	done < "${file:-/dev/stdin}"
}

F_lcompose() {
	local fn1="$1"
	local fn2="$2"
	eval "$fn1 | $fn2"
}

F_rcompose() {
	local fn1="$1"
	local fn2="$2"
	eval "$fn2 | $fn1"
}
