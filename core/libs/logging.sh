#!/usr/bin/env bash

_get_caller_info() {
  local script_name=""
  local line_num=""
  local func_name=""

  # Handle zsh vs bash differently
  if [[ -n "$ZSH_VERSION" ]]; then
    # In zsh, use funcstack and funcfiletrace
    if [[ ${#funcstack[@]} -gt 3 ]]; then
      func_name="${funcstack[4]:-main}"
    fi
    if [[ ${#funcfiletrace[@]} -gt 2 ]]; then
      local trace="${funcfiletrace[3]}"
      if [[ "$trace" =~ ^(.*):([0-9]+)$ ]]; then
        script_name="$(basename "${BASH_REMATCH[1]}")"
        line_num="${BASH_REMATCH[2]}"
      fi
    fi
  else
    # FIX: not working in bash
    # In bash, use BASH_SOURCE and related arrays
    for ((i=1; i<${#BASH_SOURCE[@]}; i++)); do
      local source_file="${BASH_SOURCE[i]}"
      if [[ -n "$source_file" && "$source_file" != "${BASH_SOURCE[0]}" ]]; then
        script_name="$(basename "$source_file")"
        line_num="${BASH_LINENO[i-1]:-0}"
        func_name="${FUNCNAME[i]:-main}"
        break
      fi
    done
  fi

  # Fallback values
  [[ -z "$script_name" ]] && script_name="shell"
  [[ -z "$line_num" ]] && line_num="0"
  [[ -z "$func_name" ]] && func_name="interactive"

  echo "${script_name}:${line_num}:${func_name}"
}

_log() {
  local level="$1"
  shift
  local message="$@"

  local caller_info="$(_get_caller_info)"
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [${level}] [${caller_info}] - ${message}" >&2
}

F_log() {
  _log "I" "$@"
}

F_log_info() {
  _log "I" "$@"
}

F_log_warn() {
  _log "W" "$@"
}

F_log_error() {
  _log "E" "$@"
}

F_log_debug() {
  _log "D" "$@"
}
