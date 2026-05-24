#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

! type tagrity &> /dev/null && gem install tagrity

