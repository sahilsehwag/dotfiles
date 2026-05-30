# ==========================================
# NAVIGATION
# ==========================================

alias groot='cd "$(git rev-parse --show-toplevel)"'

# ==========================================
# PROJECTS
# ==========================================

# Emit "relative<TAB>full" pairs for every package.json dir under the git root.
_cdp_projects() {
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || return 1
  while IFS= read -r f; do
    local p="${f%/package.json}"
    printf '%s\t%s\n' "${p#${root}/}" "$p"
  done < <(find "$root" -name "package.json" \
    -not -path "*/node_modules/*" \
    -not -path "*/.git/*" \
    -maxdepth 8 \
    2>/dev/null)
}

_cdp() {
  if (( $+commands[fzf] )); then
    local selected
    selected=$(
      _cdp_projects \
        | fzf --height=40% --prompt="project> " \
              --delimiter=$'\t' --with-nth=1 \
        | cut -f2
    )
    [[ -n "$selected" ]] && compadd -Q -- "$selected"
  else
    local -a labels descs
    local rel full
    while IFS=$'\t' read -r rel full; do
      labels+=("$full")
      descs+=("$rel")
    done < <(_cdp_projects)
    compadd -d descs -a labels
  fi
}
compdef _cdp cdp

# cd to a fe project (dir with package.json); fzf picker with no args.
cdp() {
  local target="${1:-}"
  local proj_path

  if [[ -z "$target" ]]; then
    proj_path=$(_cdp_projects \
      | fzf --prompt="project> " --delimiter=$'\t' --with-nth=1 \
      | cut -f2)
  elif [[ -d "$target" ]]; then
    proj_path="$target"
  else
    local rel full
    while IFS=$'\t' read -r rel full; do
      if [[ "$rel" == "$target" || "$full" == "$target" || "${full:t}" == "$target" || "$rel" == *"$target"* ]]; then
        proj_path="$full"
        break
      fi
    done < <(_cdp_projects)
  fi

  [[ -z "$proj_path" ]] && { echo "cdp: no matching project"; return 1; }
  cd "$proj_path" || return 1
}
