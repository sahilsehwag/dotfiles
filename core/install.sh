#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

/bin/sh -x $script_directory/variables.sh
/bin/sh -x $script_directory/paths.sh
