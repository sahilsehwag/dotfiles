#!/usr/bin/env bash
# require.sh — dependency guard with interactive install prompt.
#
# Usage:
#   source /path/to/core/libs/require.sh
#
#   require <cmd>                     # prompt to install if missing; exit 1 if declined
#   require <cmd> --hint "message"    # show a custom hint when the package can't be auto-installed
#   require <cmd> --no-exit           # return 1 instead of exiting (useful in functions)
#
# The install step delegates to F_pkg_install (core/libs/pacman.sh), which tries
# every detected package manager (brew, apt, pacman, …) in order.  If you need a
# package name that differs from the binary name, pass it explicitly:
#   require gum --pkg charmbracelet/gum   # not used yet, reserved for future


_require_find_pacman() {
  # Return the first available package-manager command on this machine.
  local managers=(brew apt apt-get pacman yay dnf yum apk pkg emerge nix-env)
  for pm in "${managers[@]}"; do
    command -v "$pm" >/dev/null 2>&1 && { printf '%s' "$pm"; return 0; }
  done
  return 1
}

require() {
  local cmd="$1"; shift
  local hint="" no_exit=0

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --hint)    hint="$2"; shift 2 ;;
      --no-exit) no_exit=1; shift ;;
      *)         shift ;;
    esac
  done

  command -v "$cmd" >/dev/null 2>&1 && return 0

  echo "⚠️  Missing dependency: $cmd"

  local pm
  if pm=$(_require_find_pacman); then
    printf "Install '%s' via %s? [y/N] " "$cmd" "$pm"
    read -r _ans </dev/tty
    if [[ "$_ans" =~ ^[Yy]$ ]]; then
      # Source pacman lib if F_pkg_install isn't loaded yet
      if ! declare -f F_pkg_install >/dev/null 2>&1; then
        local _dir
        _dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        # shellcheck source=core/libs/pacman.sh
        source "$_dir/pacman.sh"
      fi
      F_pkg_install "$cmd"
      if command -v "$cmd" >/dev/null 2>&1; then
        echo "✅ $cmd installed successfully"
        return 0
      else
        echo "❌ Installation failed. Install $cmd manually and retry."
      fi
    fi
  else
    echo "❌ No supported package manager found."
  fi

  if [[ -n "$hint" ]]; then
    echo "   $hint"
  fi

  if (( no_exit )); then
    return 1
  fi
  exit 1
}
