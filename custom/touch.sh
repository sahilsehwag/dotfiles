#function touch() {
#  if [[ "$@" == */ ]] then
#    mkdir -p $@
#  else
#    for f in "$@"; do mkdir -p "$(dirname "$f")"; done
#    touch "$@"
#  fi
#}
