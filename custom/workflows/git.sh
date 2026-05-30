# ==========================================
# UTILS
# ==========================================

# Emit "branch<TAB>path" lines for every worktree; falls back to dir basename for detached HEAD.
_cdg_worktrees() {
  local worktree_path='' branch='' head=''
  while IFS= read -r line; do
    case "$line" in
    'worktree '*)
      worktree_path="${line#worktree }"
      branch=''
      head=''
      ;;
    'HEAD '*)
      head="${line#HEAD }"
      head="${head:0:8}"
      ;;
    'branch '*)
      branch="${line#branch refs/heads/}"
      ;;
    '')
      if [[ -n "$worktree_path" ]]; then
        printf '%s\t%s\n' "${branch:-${worktree_path:t}}" "$worktree_path"
        worktree_path=''
      fi
      ;;
    esac
  done < <(git worktree list --porcelain 2>/dev/null)
  [[ -n "$worktree_path" ]] && printf '%s\t%s\n' "${branch:-${worktree_path:t}}" "$worktree_path"
}

_cdg() {
  if (( $+commands[fzf] )); then
    local selected
    selected=$(
      _cdg_worktrees \
        | fzf --height=40% --prompt="worktree> " \
              --delimiter=$'\t' --with-nth=1 \
        | cut -f2
    )
    [[ -n "$selected" ]] && compadd -Q -- "$selected"
  else
    local -a labels descs
    local b p
    while IFS=$'\t' read -r b p; do
      labels+=("$p")
      descs+=("${p:t}  [$b]")
    done < <(_cdg_worktrees)
    compadd -d descs -a labels
  fi
}
compdef _cdg cdg

# ==========================================
# NAVIGATION
# ==========================================

# cd to a worktree by branch name, dir name, or full path; fzf picker with no args.
cdg() {
  local target="${1:-}"
  local wt_path  # avoid shadowing zsh's special $path array

  if [[ -z "$target" ]]; then
    wt_path=$(_cdg_worktrees |
      fzf --prompt="worktree> " --delimiter=$'\t' --with-nth=1 --preview='echo {2}' |
      cut -f2)
  elif [[ -d "$target" ]]; then
    wt_path="$target"
  else
    local b w
    while IFS=$'\t' read -r b w; do
      if [[ "$b" == "$target" || "$w" == "$target" || "${w:t}" == "$target" ]]; then
        wt_path="$w"
        break
      fi
    done < <(_cdg_worktrees)
  fi

  [[ -z "$wt_path" ]] && { echo "cdg: no matching worktree"; return 1; }
  cd "$wt_path" || return 1
}
