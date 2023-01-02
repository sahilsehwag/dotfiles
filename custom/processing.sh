#!/usr/bin/env bash

function processing() {
	rm -rf /tmp/processing
	mkdir /tmp/processing
	processing-java --output=/tmp/processing/ --force --sketch=$1 --run
}
