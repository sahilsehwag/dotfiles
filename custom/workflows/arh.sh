#!/usr/bin/env bash
#
# ═══════════════════════════════════════════════════════════════════════════
#  arh.sh — workflow wrappers around Uber's `arh` GitHub CLI
# ═══════════════════════════════════════════════════════════════════════════
#
# Audience: humans at a terminal AND scripts / LLM tool callers.
# Every function below is dual-mode: pass args for a fully non-interactive
# (programmatic) invocation, or omit them to be prompted via `gum`.
#
# ── PUBLIC FUNCTIONS ────────────────────────────────────────────────────────
#   arh-feature                  Create one feature branch off a fresh default
#   arh-feature-tree             Create N branches in a parent/child tree
#                                  --pick  also cherry-pick distribute commits
#   arh-merge                    Run `arh merge` from a stack leaf (with cap)
#   arh-restack-to-main          Pull default, jz install, restack + arh rebase
#   arh-review                   Stash → checkout PR → soft-reset for line diff
#
# ── COMMON CONVENTIONS ──────────────────────────────────────────────────────
#   -y / --yes        Skip all confirmation prompts (or export ARH_YES=1).
#                     Required for unattended / scripted use.
#   -k / --pick       Enable cherry-pick distribution mode (arh-feature-tree).
#   -r / --root B     Root parent branch (tree-creating fns).
#   -s / --source B   Source branch with commits to distribute.
#   -m / --max-stack N
#                     Cap on stack size before refusing to publish/merge.
#   -f / --tree-file P
#                     Read the tree DSL from a file ('-' for stdin) instead
#                     of opening the `gum write` editor.
#
# ── INTERNAL HELPERS ────────────────────────────────────────────────────────
#   _arh_confirm        gum confirm wrapper that honours ARH_YES=1.
#   _arh_default_branch Resolve the repo default branch (main/master/...).
#
# ── DEPENDENCIES ────────────────────────────────────────────────────────────
#   Required: git, arh (Uber's GitHub fork CLI), gum (charmbracelet).
#   Optional: jz       (Uber dep manager; only used by arh-restack-to-main).
#   From arc.sh: _ui_header, _ui_success, _ui_warn, _ui_error, _ui_confirm,
#                _run_step, _ensure_git_repo, _branch_exists.
#
# ── TREE DSL (used by arh-feature-tree) ────────────────────────────────────
#   • One branch per line.
#   • Indentation defines parentage: a line is the child of the nearest line
#     above it with strictly smaller indent. Top-level lines hang off `--root`.
#   • Tabs count as 2 spaces. Blank lines ignored.
#   • In *--pick* mode, append commits after the name:
#       feat-auth: #1 #2 #3        # single refs (positions in source branch)
#       feat-payments: #7-#9       # inclusive range
#       feat-other: abc1234        # explicit short SHA also accepted
#     If NO refs anywhere, commits are auto-assigned 1:1 in order.
#
#   Example:
#     feat-auth
#       feat-auth-ui
#       feat-auth-api
#     feat-payments
#       feat-payments-stripe
#
# ── EXAMPLES (programmatic) ────────────────────────────────────────────────
#   arh-feature feat-billing develop -y
#   echo 'feat-a
#     feat-a-ui
#     feat-a-api' | arh-feature-tree -r main -f - -y
#   arh-feature-tree --pick \
#       --root main --source feat/big --tree-file plan.txt \
#       --max-stack 12 --publish --yes
#   ARH_YES=1 arh-restack-to-main
#   arh-merge -m 8 -y
#
# ═══════════════════════════════════════════════════════════════════════════

# ── DEPENDENCY GUARD ────────────────────────────────────────────────────────
# require is sourced once by custom/install.sh

# ────────────────────────────────────────────────────────────────────────────

# Confirm helper that respects ARH_YES=1 (set by per-function -y/--yes flags).
# Use in place of `gum confirm` inside arh-* functions so they're scriptable.
_arh_confirm() {
  (( ${ARH_YES:-0} )) && return 0
  gum confirm "$@"
}

# ══════════════════════════════════════════════════════════════════════════
# arh-feature-tree — create a hierarchy of `arh feature` branches, with
#                    optional commit distribution via cherry-pick (--pick)
# ══════════════════════════════════════════════════════════════════════════
#
# Default mode  — create the branch tree only:
#   Reads a tree DSL (see top-of-file), then for each line runs
#     arh feature -p <resolved-parent> <name>
#   in topological order. Root defaults to the *current branch*.
#
# --pick mode  — additionally distribute commits from a source branch:
#   Same tree DSL with optional per-line commit refs. Per-branch execution:
#     ① git checkout <parent-actual>
#     ② arh feature -p <parent-actual> <name>
#     ③ git rebase <parent-actual>      (inherit parent's cherry-picks)
#     ④ git cherry-pick <commit> ...    (apply this branch's own commits)
#   Root defaults to the repo default branch (main/master/…).
#
# After execution, if the resulting stack ≤ --max-stack, the function
# checks out the last-created branch (deepest leaf) so a follow-up
# `arh publish` operates on the whole stack. If the stack exceeds the cap
# it stays on root_parent and skips publish.
#
# Args / flags:
#   [root_parent]         Positional. Branch the tree roots off of.
#   -r, --root <branch>   Same as positional (takes precedence).
#   -k, --pick            Enable cherry-pick distribution mode.
#   -s, --source <branch> Source branch with commits (required with --pick).
#   -f, --tree-file <p>   Read tree DSL from file ('-' = stdin). Skips editor.
#   -m, --max-stack <N>   Max stack size before publish is suppressed. Default 20.
#   -p, --publish         Run `arh publish` from the leaf when done.
#   -y, --yes             Skip all confirmations.
#
# Commit-ref syntax (--pick mode only):
#   #N            → commit at position N in source_branch (1-indexed, oldest=1)
#   #N-#M         → inclusive range
#   <short-sha>   → explicit git ref (validated)
#   If NO refs anywhere → 1:1 auto-assign (commit #k → branch #k).
#
# Examples:
#   arh-feature-tree                          # interactive tree-only
#   arh-feature-tree main                     # explicit root, editor for tree
#   arh-feature-tree -r main -f tree.txt -y   # programmatic tree-only
#   echo 'feat-a
#     feat-a-ui' | arh-feature-tree -r main -f - -y
#   arh-feature-tree --pick -r main -s feat/big -f plan.txt -p -y
arh-feature-tree() {

  # ── flag parsing ────────────────────────────────────────────────────────
  local _pick=0
  local _do_publish=0
  local _max_stack=20
  local _root_arg=""
  local _source_arg=""
  local _tree_file=""
  local ARH_YES=0
  local _expect_max=0 _expect_root=0 _expect_source=0 _expect_file=0
  local _a
  for _a in "$@"; do
    if (( _expect_max ));    then _max_stack="$_a";   _expect_max=0;    continue; fi
    if (( _expect_root ));   then _root_arg="$_a";    _expect_root=0;   continue; fi
    if (( _expect_source )); then _source_arg="$_a";  _expect_source=0; continue; fi
    if (( _expect_file ));   then _tree_file="$_a";   _expect_file=0;   continue; fi
    case "$_a" in
      --pick|-k)        _pick=1 ;;
      --publish|-p)     _do_publish=1 ;;
      --yes|-y)         ARH_YES=1 ;;
      --max-stack|-m)   _expect_max=1 ;;
      --max-stack=*)    _max_stack="${_a#*=}" ;;
      --root|-r)        _expect_root=1 ;;
      --root=*)         _root_arg="${_a#*=}" ;;
      --source|-s)      _expect_source=1 ;;
      --source=*)       _source_arg="${_a#*=}" ;;
      --tree-file|-f)   _expect_file=1 ;;
      --tree-file=*)    _tree_file="${_a#*=}" ;;
      -*)               _ui_error "Unknown flag: $_a"; return 1 ;;
      *)                [[ -z "$_root_arg" ]] && _root_arg="$_a" ;;
    esac
  done

  if [[ -n "$_tree_file" && "$_tree_file" != "-" && ! -r "$_tree_file" ]]; then
    _ui_error "Tree file not readable: $_tree_file"; return 1
  fi
  [[ "$_max_stack" =~ ^[0-9]+$ ]] || {
    _ui_error "--max-stack must be a positive integer (got '$_max_stack')"; return 1
  }

  _ensure_git_repo || return 1
  command -v arh >/dev/null || { _ui_error "Missing dependency: arh"; return 1; }

  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  [[ "$current_branch" == "HEAD" ]] && {
    _ui_error "Detached HEAD — checkout a branch first"; return 1
  }

  # ── header ──────────────────────────────────────────────────────────────
  local _mode_label=""
  (( _pick )) && _mode_label=" + DISTRIBUTE"
  (( _do_publish )) && _mode_label+="  [--publish max-stack=$_max_stack]"
  _ui_header "ARH FEATURE TREE${_mode_label}"

  # ── root parent ─────────────────────────────────────────────────────────
  local _default_root
  if (( _pick )); then
    _default_root=$(_arh_default_branch 2>/dev/null) || _default_root="main"
  else
    _default_root="$current_branch"
  fi
  local root_parent="$_root_arg"
  if [[ -z "$root_parent" ]]; then
    root_parent=$(gum input --placeholder "$_default_root" --prompt "Root parent branch > ")
    root_parent="${root_parent:-$_default_root}"
  fi
  git show-ref --verify --quiet "refs/heads/$root_parent" || {
    _ui_error "Branch '$root_parent' does not exist"; return 1
  }

  # ── source branch + commit collection (pick mode only) ──────────────────
  local source_branch=""
  local -a _cshas=() _cmsgs=()
  local total_commits=0

  if (( _pick )); then
    source_branch="$_source_arg"
    if [[ -z "$source_branch" ]]; then
      source_branch=$(gum input --placeholder "" --prompt "Source branch (with commits) > ")
    fi
    [[ -z "$source_branch" ]] && { _ui_error "Source branch required for --pick"; return 1; }
    git rev-parse --verify --quiet "$source_branch" &>/dev/null || {
      _ui_error "Branch '$source_branch' not found"; return 1
    }

    local merge_base
    merge_base=$(git merge-base "$source_branch" "$root_parent" 2>/dev/null)
    if [[ -n "$merge_base" ]]; then
      while IFS= read -r _l; do
        [[ -z "$_l" ]] && continue
        _cshas+=("${_l%% *}"); _cmsgs+=("$_l")
      done < <(git log --oneline --reverse "$merge_base..$source_branch")
    else
      while IFS= read -r _l; do
        [[ -z "$_l" ]] && continue
        _cshas+=("${_l%% *}"); _cmsgs+=("$_l")
      done < <(git log --oneline --reverse -30 "$source_branch")
    fi

    total_commits=${#_cshas[@]}
    [[ $total_commits -eq 0 ]] && {
      _ui_warn "No commits on '$source_branch' beyond '$root_parent'"; return 0
    }

    echo ""
    gum style --bold --foreground 212 "$total_commits commits on '$source_branch' (oldest → newest):"
    local _ci
    for (( _ci = 1; _ci <= ${#_cmsgs[@]}; _ci++ )); do
      printf "  $(tput setaf 141)#%-3d$(tput sgr0) %s\n" "$_ci" "${_cmsgs[$_ci]}"
    done
    echo ""
  fi

  # ── tree input ───────────────────────────────────────────────────────────
  local raw_input
  if [[ -n "$_tree_file" ]]; then
    if [[ "$_tree_file" == "-" ]]; then
      raw_input=$(cat)
      gum style --foreground 240 "Tree read from stdin"
    else
      raw_input=$(<"$_tree_file")
      gum style --foreground 240 "Tree read from $_tree_file"
    fi
  elif (( _pick )); then
    raw_input=$(gum write \
      --header "root: $root_parent  |  source: $source_branch  |  indent=child  |  branch: #N or #N-#M  |  Ctrl+J=newline  Ctrl+D=submit" \
      --placeholder "feat-auth: #1 #2 #3
  feat-auth-ui: #4 #5
  feat-auth-api: #6
feat-payments: #7-#9" \
      --width 80 --height 18 --char-limit 0 --show-line-numbers)
  else
    raw_input=$(gum write \
      --header "Rooted at '$root_parent'  |  indent = child  |  Ctrl+D to confirm" \
      --placeholder "feat-auth
  feat-auth-ui
  feat-auth-api
feat-payments
  feat-payments-stripe" \
      --width 60 --height 15 --show-line-numbers --show-help)
  fi
  [[ -z "${raw_input// }" ]] && { _ui_warn "No input provided."; return 0; }

  # ── parse ────────────────────────────────────────────────────────────────
  local -a _lines=() _cols=() _commit_strs=()
  local _has_any_refs=0

  while IFS= read -r _line; do
    _line="${_line//$'\t'/  }"
    local _rest="${_line#"${_line%%[! ]*}"}"
    [[ -z "${_rest// }" ]] && continue
    local _col=$(( ${#_line} - ${#_rest} ))

    local _bname="" _refs=""

    if (( _pick )); then
      if [[ "$_rest" == *:* ]]; then
        _bname="${_rest%%:*}"
        _refs="${_rest#*:}"
      else
        local -a _tokens=()
        _tokens=(${(z)_rest})
        local _found_ref=0
        for _tok in "${_tokens[@]}"; do
          if (( _found_ref )); then
            _refs+="$_tok "
          elif [[ "$_tok" =~ ^\# ]]; then
            _found_ref=1; _refs+="$_tok "
          elif git rev-parse --verify --quiet "$_tok" &>/dev/null 2>&1 && [[ ${#_tok} -ge 7 ]]; then
            _found_ref=1; _refs+="$_tok "
          else
            _bname+="${_bname:+ }$_tok"
          fi
        done
      fi
    else
      _bname="$_rest"
    fi

    _bname="${_bname#"${_bname%%[! ]*}"}"
    _bname="${_bname%"${_bname##*[![:space:]]}"}"
    [[ -z "$_bname" ]] && continue

    local -a resolved=()
    if (( _pick )); then
      for ref in ${(z)_refs}; do
        ref="${ref// }"; [[ -z "$ref" ]] && continue
        if [[ "$ref" =~ ^\#([0-9]+)-\#([0-9]+)$ ]]; then
          _has_any_refs=1
          for (( _ri = match[1]; _ri <= match[2]; _ri++ )); do
            [[ -n "${_cshas[$_ri]}" ]] && resolved+=("${_cshas[$_ri]}")
          done
        elif [[ "$ref" =~ ^\#([0-9]+)$ ]]; then
          _has_any_refs=1
          [[ -n "${_cshas[${match[1]}]}" ]] && resolved+=("${_cshas[${match[1]}]}")
        else
          if git rev-parse --verify --quiet "$ref" &>/dev/null; then
            _has_any_refs=1; resolved+=("$(git rev-parse --short "$ref")")
          else
            _ui_warn "Unknown ref '$ref' — skipped"
          fi
        fi
      done
    fi

    _lines+=("$_bname")
    _cols+=("$_col")
    _commit_strs+=("${resolved[*]}")
  done <<< "$raw_input"

  local _nlines=${#_lines[@]}
  [[ $_nlines -eq 0 ]] && { _ui_warn "Nothing parsed."; return 0; }

  # ── auto-assign commits when no refs given (pick mode only) ─────────────
  if (( _pick && ! _has_any_refs )); then
    if (( _nlines > total_commits )); then
      _ui_warn "More branches ($_nlines) than commits ($total_commits) — extra branches will be empty"
      for (( _i = 1; _i <= _nlines; _i++ )); do
        (( _i <= total_commits )) && _commit_strs[$_i]="${_cshas[$_i]}" || _commit_strs[$_i]=""
      done
    elif (( _nlines < total_commits )); then
      _ui_error "Fewer branches ($_nlines) than commits ($total_commits) — cannot auto-assign"
      _ui_warn "Either add more branches or use explicit refs (#N, #N-#M)"
      return 1
    else
      for (( _i = 1; _i <= _nlines; _i++ )); do _commit_strs[$_i]="${_cshas[$_i]}"; done
    fi
    gum style --foreground 99 "Auto-assigned: 1 commit per branch"
  fi

  # ── pass 2: determine parents ────────────────────────────────────────────
  local -a node_names=() node_parents=() node_commits=()
  local _i _j
  for (( _i = 1; _i <= _nlines; _i++ )); do
    local _parent="$root_parent"
    for (( _j = _i - 1; _j >= 1; _j-- )); do
      (( _cols[$_j] < _cols[$_i] )) && { _parent="${_lines[$_j]}"; break; }
    done
    node_names+=("${_lines[$_i]}")
    node_parents+=("$_parent")
    node_commits+=("${_commit_strs[$_i]}")
  done

  # ── preview (shared; commit info shown only in pick mode) ───────────────
  echo ""
  if (( _pick )); then
    gum style --bold --foreground 212 "Plan:  root=$root_parent  source=$source_branch"
  else
    gum style --bold --foreground 212 "Parsed tree (root=$root_parent):"
  fi

  _aft_preview() {
    local _nn="$1" _dd="$2" _ind="" _jj _ki
    for (( _jj = 0; _jj < _dd; _jj++ )); do _ind+="  "; done
    local _prefix
    (( _dd == 0 )) && _prefix="${_ind}${_nn}" || _prefix="${_ind}+-- ${_nn}"
    local _cinfo=""
    if (( _pick )); then
      for (( _ki = 1; _ki <= ${#node_names[@]}; _ki++ )); do
        if [[ "${node_names[$_ki]}" == "$_nn" && -n "${node_commits[$_ki]}" ]]; then
          local _wc; _wc=$(echo "${node_commits[$_ki]}" | wc -w | tr -d ' ')
          _cinfo="  ← ${_wc} commit(s)"
          break
        fi
      done
    fi
    printf "  %s%s\n" "$_prefix" "$_cinfo"
    if (( _pick )); then
      for (( _ki = 1; _ki <= ${#node_names[@]}; _ki++ )); do
        if [[ "${node_names[$_ki]}" == "$_nn" && -n "${node_commits[$_ki]}" ]]; then
          for _s in ${(z)${node_commits[$_ki]}}; do
            printf "  %s    ▸ %s\n" "$_ind" "$(git log --oneline -1 "$_s" 2>/dev/null)"
          done
        fi
      done
    fi
    for (( _ki = 1; _ki <= ${#node_names[@]}; _ki++ )); do
      [[ "${node_parents[$_ki]}" == "$_nn" ]] && _aft_preview "${node_names[$_ki]}" $(( _dd + 1 ))
    done
  }

  _aft_preview "$root_parent" 0
  echo ""
  (( _do_publish )) && gum style --foreground 212 "  Will run 'arh publish' on completion"
  echo ""

  local _confirm_msg="Create this feature tree?"
  (( _pick )) && _confirm_msg="Create tree and distribute?"
  _arh_confirm "$_confirm_msg" || return 0

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # EXECUTE — topological order (parents before children)
  #   ① checkout parent    [pick only] → correct base for arh feature
  #   ② arh feature -p parent name
  #   ③ rebase onto parent [pick only] → inherit parent's cherry-picks
  #   ④ cherry-pick        [pick only] → apply this branch's own commits
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  local _total=${#node_names[@]}
  local -a _actual=()
  local _k

  for (( _k = 1; _k <= _total; _k++ )); do
    local _bname="${node_names[$_k]}"
    local _bparent="${node_parents[$_k]}"
    local _commits="${node_commits[$_k]}"

    local _bparent_actual="$_bparent"
    local _pi
    for (( _pi = 1; _pi < _k; _pi++ )); do
      [[ "${node_names[$_pi]}" == "$_bparent" ]] && {
        _bparent_actual="${_actual[$_pi]}"; break
      }
    done

    echo ""
    gum style --bold --foreground 212 "[$_k/$_total] $_bname"

    # ① checkout parent (pick only)
    if (( _pick )); then
      gum style --foreground 240 "  ① checkout $_bparent_actual"
      git checkout "$_bparent_actual" 2>/dev/null || {
        _ui_error "Cannot checkout '$_bparent_actual'"; return 1
      }
    fi

    # ② create feature branch
    local _step_n; (( _pick )) && _step_n="②" || _step_n="①"
    gum style --foreground 240 "  ${_step_n} arh feature -p $_bparent_actual $_bname"
    arh feature -p "$_bparent_actual" "$_bname" || {
      _ui_error "Failed to create '$_bname'"; return 1
    }

    local _created
    _created=$(git rev-parse --abbrev-ref HEAD)
    _actual+=("$_created")
    gum style --foreground 240 "    → $_created"

    if (( _pick )); then
      # ③ rebase onto parent (inherit parent's cherry-picks)
      gum style --foreground 240 "  ③ rebase onto $_bparent_actual"
      if ! git rebase "$_bparent_actual" 2>/dev/null; then
        _ui_warn "    rebase conflict — resolve, then press Enter…"
        read -r
        git rebase --continue 2>/dev/null || {
          _ui_error "    rebase failed"
          git rebase --abort 2>/dev/null
          return 1
        }
      fi

      # ④ cherry-pick
      if [[ -n "$_commits" ]]; then
        local _cnt
        _cnt=$(echo "$_commits" | wc -w | tr -d ' ')
        gum style --foreground 99 "  ④ cherry-pick $_cnt commit(s)"
        for _s in ${(z)_commits}; do
          gum style --foreground 240 "    ▸ $(git log --oneline -1 "$_s" 2>/dev/null)"
          if ! git cherry-pick "$_s" 2>/dev/null; then
            _ui_error "    conflict on $_s"
            local action
            action=$(gum choose \
              "resolve (fix now)" "skip this commit" "abort everything" \
              --header "How to proceed?" --cursor "▸ ")
            case "$action" in
              resolve*)
                _ui_warn "    fix conflicts, stage, then press Enter…"
                read -r
                git cherry-pick --continue 2>/dev/null || {
                  _ui_error "    --continue failed"; return 1
                } ;;
              skip*)
                git cherry-pick --skip 2>/dev/null
                _ui_warn "    ⏭ skipped" ;;
              abort*)
                git cherry-pick --abort 2>/dev/null
                return 1 ;;
            esac
          fi
        done
      else
        gum style --foreground 240 "  ④ no commits assigned"
      fi
    fi
  done

  # ── finalise ────────────────────────────────────────────────────────────
  echo ""
  local _success_msg="Feature tree created!"
  (( _pick )) && _success_msg="Feature tree created and commits distributed!"
  _ui_success "$_success_msg"
  echo ""

  local _stack_total="${#_actual[@]}"
  local _leaf_branch=""
  (( _stack_total > 0 )) && _leaf_branch="${_actual[$_stack_total]}"

  if (( _stack_total > _max_stack )); then
    _ui_warn "Stack size ($_stack_total) exceeds --max-stack ($_max_stack) — staying on '$root_parent'"
    (( _do_publish )) && _ui_warn "Skipping 'arh publish' — split the stack manually first"
    _do_publish=0
    git checkout "$root_parent" 2>/dev/null
  elif [[ -n "$_leaf_branch" ]]; then
    gum style --foreground 240 "Checking out leaf '$_leaf_branch' (stack size $_stack_total ≤ $_max_stack)"
    git checkout "$_leaf_branch" 2>/dev/null || {
      _ui_warn "Could not checkout '$_leaf_branch' — falling back to '$root_parent'"
      git checkout "$root_parent" 2>/dev/null
    }
  else
    git checkout "$root_parent" 2>/dev/null
  fi

  arh -p

  if (( _do_publish )); then
    echo ""
    gum style --bold --foreground 212 "Publishing from '$(git rev-parse --abbrev-ref HEAD)'…"
    arh publish
  fi
}


# ══════════════════════════════════════════════════════════════════════════
# arh-review — set up a PR review environment, then tear it down
# ══════════════════════════════════════════════════════════════════════════
#
# Walks a 6-step review flow:
#   1. Stash local changes if dirty (remembers stash index).
#   2. `arh checkout <PR> --force` (warns if you have unpushed commits).
#   3. `git reset --mixed HEAD~1` so the PR's last commit appears as an
#      uncommitted diff — easy to walk in your editor.
#   4. Prompt: "Finish review?" — choose 'no' to leave the env intact and
#      re-run later, or 'yes' to start cleanup.
#   5. Cleanup: `git reset --hard`, `git checkout <original>`, delete PR branch.
#   6. Pop the stash if one was saved.
#
# Args:
#   <PR>   PR number or full GitHub PR URL. Required.
#
# Behaviour:
#   • Refuses to run from detached HEAD.
#   • Refuses if PR has only 1 commit (cannot reset HEAD~1).
#   • Stash is preserved if pop conflicts on restore.
#   • The "Finish review?" prompt uses _ui_confirm (NOT _arh_confirm) so it
#     intentionally always asks — review is a manual inspection step.
#
# Examples:
#   arh-review 12345
#   arh-review https://github.com/uber/repo/pull/12345
arh-review() {

  _ensure_git_repo || return 1

  if [ -z "${1:-}" ]; then
    _ui_error "Usage: arh-review <PR-number-or-URL>"
    return 1
  fi

  command -v arh >/dev/null || {
    _ui_error "❌ Missing dependency: arh"
    return 1
  }

  local PR="$1"
  local TOTAL_STEPS=6

  # Guard: detached HEAD
  local original_branch
  original_branch=$(git rev-parse --abbrev-ref HEAD)
  if [ "$original_branch" = "HEAD" ]; then
    _ui_error "❌ Detached HEAD — checkout a branch first"
    return 1
  fi

  _ui_header "ARH REVIEW — $PR"

  # Step 1 — Stash if dirty (capture index by position)
  local stash_index=-1
  if [ -n "$(git status --porcelain)" ]; then
    local stash_count_before
    stash_count_before=$(git stash list | wc -l)
    _run_step 1 "$TOTAL_STEPS" "Stashing local changes" \
      "git stash save 'arh-review-stash-$PR'" || return 1
    local stash_count_after
    stash_count_after=$(git stash list | wc -l)
    if [ "$stash_count_after" -gt "$stash_count_before" ]; then
      stash_index=0
    fi
  else
    _ui_warn "[1/$TOTAL_STEPS] No local changes to stash"
  fi

  # Step 2 — Checkout the PR (with unpushed-commits warning)
  local unpushed
  unpushed=$(git log --branches --not --remotes --oneline 2>/dev/null | wc -l)
  if [ "$unpushed" -gt 0 ]; then
    _ui_warn "⚠️  You have $unpushed unpushed commit(s). --force will discard any local branch that matches the PR branch."
    _ui_confirm "Continue anyway?" || {
      if [ "$stash_index" -ge 0 ]; then
        git stash pop "stash@{$stash_index}" >/dev/null 2>&1 || true
      fi
      return 1
    }
  fi

  local checkout_output checkout_exit
  checkout_output=$(arh checkout "$PR" --force 2>&1)
  checkout_exit=$?
  if [ $checkout_exit -ne 0 ]; then
    _ui_error "❌ arh checkout failed:\n$checkout_output"
    if [ "$stash_index" -ge 0 ]; then
      git stash pop "stash@{$stash_index}" >/dev/null 2>&1 || true
    fi
    return 1
  fi
  _ui_success "[2/$TOTAL_STEPS] Checked out PR $PR"

  local review_branch
  review_branch=$(git rev-parse --abbrev-ref HEAD)

  # Guard: need at least 2 commits to reset
  local commit_count
  commit_count=$(git log --oneline 2>/dev/null | wc -l)
  if [ "$commit_count" -lt 2 ]; then
    _ui_error "❌ Only $commit_count commit on this branch — cannot reset HEAD~1"
    git checkout "$original_branch" >/dev/null 2>&1 || true
    if [ "$stash_index" -ge 0 ]; then
      git stash pop "stash@{$stash_index}" >/dev/null 2>&1 || true
    fi
    return 1
  fi

  # Step 3 — Mixed reset to expose diff in editor
  _run_step 3 "$TOTAL_STEPS" "Reset commit for editor diff" \
    "git reset --mixed HEAD~1" || {
      git checkout "$original_branch" >/dev/null 2>&1 || true
      if [ "$stash_index" -ge 0 ]; then
        git stash pop "stash@{$stash_index}" >/dev/null 2>&1 || true
      fi
      return 1
    }

  _ui_success "
✅ Review environment ready

  PR branch   : $review_branch
  Original    : $original_branch
  Stash saved : $([ "$stash_index" -ge 0 ] && echo "yes (index $stash_index)" || echo "no")
"

  _ui_confirm "Finish review and cleanup?" || {
    _ui_warn "
Leaving review environment intact.

  Current branch : $review_branch
  Original       : $original_branch
  Stash index    : $([ "$stash_index" -ge 0 ] && echo "$stash_index" || echo "none")

Run 'arh-review $PR' again after you're done to cleanup.
"
    return 0
  }

  # Step 4 — Discard uncommitted review notes
  _run_step 4 "$TOTAL_STEPS" "Discarding review changes" \
    "git reset --hard" || return 1

  # Step 5 — Restore original branch
  _run_step 5 "$TOTAL_STEPS" "Returning to $original_branch" \
    "git checkout '$original_branch'" || return 1

  # Delete review branch if it still exists
  if _branch_exists "$review_branch"; then
    git branch -D "$review_branch" >/dev/null 2>&1 || true
  fi

  # Step 6 — Pop stash
  if [ "$stash_index" -ge 0 ]; then
    _run_step 6 "$TOTAL_STEPS" "Restoring stash" \
      "git stash pop 'stash@{$stash_index}' || echo '⚠️  Stash preserved due to conflicts'"
  else
    _ui_success "[6/$TOTAL_STEPS] No stash to restore"
  fi

  _ui_success "
🎉 Review workflow completed successfully
"
}

# ══════════════════════════════════════════════════════════════════════════
# arh-merge — checkout a stack's leaf branch and run `arh merge`
# ══════════════════════════════════════════════════════════════════════════
#
# Different repos cap the number of PRs that can land in one stack.
# This wrapper auto-detects current stack size (best-effort parse of `arh -p`),
# refuses to merge if it exceeds --max-stack, optionally switches to a chosen
# leaf branch, then runs `arh merge`.
#
# Args / flags:
#   [leaf]              Positional. Branch to merge from. Default = current.
#   -m, --max-stack <N> Refuse if detected stack > N. Default 10.
#   -y, --yes           Skip the final "Run arh merge?" confirmation.
#
# Behaviour:
#   • If `arh -p` parsing fails (no recognisable branches in output), the
#     stack-size check is skipped with a warning rather than blocking.
#   • Does NOT pull or restack — call arh-restack-to-main first if needed.
#
# Examples:
#   arh-merge                          # max=10, current branch
#   arh-merge -m 5                     # tighten cap
#   arh-merge -m 5 my-leaf-branch -y   # programmatic
arh-merge() {

  local _max_stack=10
  local _leaf=""
  local _expect_max=0
  local ARH_YES=0
  local _a
  for _a in "$@"; do
    if (( _expect_max )); then
      _max_stack="$_a"
      _expect_max=0
      continue
    fi
    case "$_a" in
      --max-stack|-m) _expect_max=1 ;;
      --max-stack=*)  _max_stack="${_a#*=}" ;;
      --yes|-y)       ARH_YES=1 ;;
      -*)             _ui_error "Unknown flag: $_a"; return 1 ;;
      *)              _leaf="$_a" ;;
    esac
  done

  [[ "$_max_stack" =~ ^[0-9]+$ ]] && (( _max_stack > 0 )) || {
    _ui_error "--max-stack must be a positive integer (got '$_max_stack')"
    return 1
  }

  _ensure_git_repo || return 1
  command -v arh >/dev/null || { _ui_error "Missing dependency: arh"; return 1; }

  local _current
  _current=$(git rev-parse --abbrev-ref HEAD)
  [[ "$_current" == "HEAD" ]] && {
    _ui_error "Detached HEAD — checkout a branch first"
    return 1
  }

  _leaf="${_leaf:-$_current}"

  git show-ref --verify --quiet "refs/heads/$_leaf" || {
    _ui_error "Branch '$_leaf' does not exist"
    return 1
  }

  _ui_header "ARH MERGE  $(gum style --foreground 212 "[max-stack=$_max_stack]")"

  echo ""
  arh -p
  echo ""

  # Best-effort stack-size detection: count branch-looking lines in `arh -p`
  # (strips ANSI). If detection fails we proceed but warn.
  local _count
  _count=$(arh -p 2>/dev/null \
    | sed $'s/\x1b\\[[0-9;]*m//g' \
    | grep -cE '^[[:space:]]*[*│├└─+`|\\\\/-]+[[:space:]]+[A-Za-z0-9._/-]+')

  if (( _count == 0 )); then
    _ui_warn "Could not auto-detect stack size from 'arh -p' — skipping max-stack check"
  else
    gum style --foreground 240 "Detected stack size: $_count branch(es)"
    if (( _count > _max_stack )); then
      _ui_error "Stack size ($_count) exceeds --max-stack ($_max_stack)"
      _ui_warn "Split the stack or raise --max-stack and re-run"
      return 1
    fi
  fi

  if [[ "$_current" != "$_leaf" ]]; then
    gum style --foreground 240 "Switching from '$_current' to leaf '$_leaf'"
    git checkout "$_leaf" 2>/dev/null || {
      _ui_error "Could not checkout '$_leaf'"
      return 1
    }
  fi

  _arh_confirm "Run 'arh merge' from '$_leaf'?" || return 0

  arh merge || {
    _ui_error "arh merge failed"
    return 1
  }

  _ui_success "
arh merge completed
"
}

# Detect this repo's default branch. Tries, in order:
#   1. origin/HEAD symbolic ref (set by `git clone` / `git remote set-head`)
#   2. `git remote show origin` (queries remote — slower but authoritative)
#   3. first existing local branch from: main, master, trunk, develop
# Echoes the branch name; returns non-zero if nothing matched.
_arh_default_branch() {
  local _b
  _b=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
  [[ -n "$_b" ]] && { echo "${_b#origin/}"; return 0; }

  _b=$(git remote show origin 2>/dev/null | awk '/HEAD branch/ {print $NF; exit}')
  [[ -n "$_b" && "$_b" != "(unknown)" ]] && { echo "$_b"; return 0; }

  local _candidate
  for _candidate in main master trunk develop; do
    if git show-ref --verify --quiet "refs/heads/$_candidate"; then
      echo "$_candidate"
      return 0
    fi
  done

  return 1
}

# ══════════════════════════════════════════════════════════════════════════
# arh-restack-to-main — sync the current stack onto the latest default branch
# ══════════════════════════════════════════════════════════════════════════
#
# Runs four steps:
#   ① git checkout <target>; git pull --ff-only origin <target>; checkout back
#   ② jz install                 (skipped if `jz` is not on PATH)
#   ③ arh restack --onto <target>
#   ④ arh rebase                 (only if `arh rebase` exists)
#
# Args / flags:
#   [target]    Positional. Branch to restack onto. Auto-detected (main/master/
#               trunk/develop or origin/HEAD) when omitted.
#   -y, --yes   Skip the dirty-tree and "Restack?" confirmations.
#
# Behaviour:
#   • Aborts if already on the target branch.
#   • Warns + asks before continuing on a dirty working tree.
#   • git pull is fast-forward-only — refuses to merge silently.
#   • jz failure is a warning, not a stop (deps can be retried).
#   • arh restack conflicts → user resolves and runs `arh restack --continue`.
#
# Examples:
#   arh-restack-to-main              # auto-detect target, interactive
#   arh-restack-to-main develop      # restack onto develop
#   arh-restack-to-main -y           # unattended
arh-restack-to-main() {

  _ensure_git_repo || return 1
  command -v arh >/dev/null || { _ui_error "Missing dependency: arh"; return 1; }

  local ARH_YES=0
  local _target=""
  local _a
  for _a in "$@"; do
    case "$_a" in
      --yes|-y) ARH_YES=1 ;;
      -*)       _ui_error "Unknown flag: $_a"; return 1 ;;
      *)        [[ -z "$_target" ]] && _target="$_a" ;;
    esac
  done

  if [[ -z "$_target" ]]; then
    _target=$(_arh_default_branch) || {
      _ui_error "Could not auto-detect default branch — pass one explicitly"
      return 1
    }
    gum style --foreground 240 "Detected default branch: $_target"
  fi

  git show-ref --verify --quiet "refs/heads/$_target" || {
    _ui_error "Target branch '$_target' does not exist locally"
    return 1
  }

  local _current
  _current=$(git rev-parse --abbrev-ref HEAD)
  [[ "$_current" == "HEAD" ]] && {
    _ui_error "Detached HEAD — checkout a branch first"
    return 1
  }
  [[ "$_current" == "$_target" ]] && {
    _ui_error "Already on '$_target' — nothing to restack"
    return 1
  }

  _ui_header "ARH RESTACK  $(gum style --foreground 212 "[$_current → $_target]")"

  echo ""
  arh -p
  echo ""

  if [[ -n "$(git status --porcelain)" ]]; then
    _ui_warn "Working tree has uncommitted changes — restack may fail or conflict"
    _arh_confirm "Continue anyway?" || return 0
  fi

  _arh_confirm "Restack '$_current' onto '$_target'?" || return 0

  # ① Fresh pull of the target — checkout, fast-forward, return to feature
  gum style --bold --foreground 212 "① Pulling latest '$_target'"
  git checkout "$_target" || {
    _ui_error "Could not checkout '$_target'"
    return 1
  }
  git pull --ff-only origin "$_target" || {
    _ui_error "git pull failed — fast-forward only; resolve divergence first"
    git checkout "$_current" 2>/dev/null
    return 1
  }
  git checkout "$_current" || {
    _ui_error "Could not return to '$_current'"
    return 1
  }

  # ② jz install — sync deps to match the updated target
  if command -v jz >/dev/null; then
    gum style --bold --foreground 212 "② jz install"
    jz install || _ui_warn "jz install failed — continuing anyway"
  else
    gum style --foreground 240 "② jz not installed — skipping"
  fi

  # ③ arh restack onto the freshly-pulled target
  gum style --bold --foreground 212 "③ arh restack --onto $_target"
  arh restack --onto "$_target" || {
    _ui_error "arh restack failed — resolve conflicts then run 'arh restack --continue'"
    return 1
  }

  # ④ arh rebase — pull in any further upstream changes across the stack
  if arh rebase --help >/dev/null 2>&1; then
    gum style --bold --foreground 212 "④ arh rebase"
    arh rebase || _ui_warn "arh rebase reported issues — review output above"
  fi

  _ui_success "
Restacked '$_current' onto '$_target'
"
  arh -p
}

# ══════════════════════════════════════════════════════════════════════════
# arh-feature — create one fresh feature branch off the default branch
# ══════════════════════════════════════════════════════════════════════════
#
# Pulls the base branch first so the new feature starts from an up-to-date tip,
# then runs `arh feature -p <base> <name>`.
#
# Args / flags:
#   <name>    Positional. Feature branch name. Prompted if missing.
#   [base]    Positional. Branch to fork from. Auto-detected default if omitted.
#
# Behaviour:
#   • Refuses to run on a dirty working tree (would block checkout/pull).
#   • git pull is fast-forward-only.
#   • arh prepends UBER_LDAP_UID — the function prints the *actual* branch
#     name created (visible in `arh -p` output at the end).
#
# Examples:
#   arh-feature feat-billing-api
#   arh-feature feat-billing-api develop
#   arh-feature                       # interactive prompt for name
arh-feature() {

  _ensure_git_repo || return 1
  command -v arh >/dev/null || { _ui_error "Missing dependency: arh"; return 1; }

  local _name="${1:-}"
  local _base="${2:-}"

  if [[ -z "$_name" ]]; then
    _name=$(gum input --placeholder "feat-name" --prompt "Feature branch name > ")
  fi
  [[ -z "$_name" ]] && { _ui_error "Branch name required"; return 1; }

  if [[ -z "$_base" ]]; then
    _base=$(_arh_default_branch) || {
      _ui_error "Could not auto-detect default branch — pass one explicitly"
      return 1
    }
  fi

  git show-ref --verify --quiet "refs/heads/$_base" || {
    _ui_error "Base branch '$_base' does not exist locally"
    return 1
  }

  _ui_header "ARH FEATURE  $(gum style --foreground 212 "[$_name ← $_base]")"

  # Guard: dirty tree would block checkout/pull
  if [[ -n "$(git status --porcelain)" ]]; then
    _ui_error "Working tree has uncommitted changes — stash or commit first"
    return 1
  fi

  local _current
  _current=$(git rev-parse --abbrev-ref HEAD)

  # Switch to base if needed
  if [[ "$_current" != "$_base" ]]; then
    gum style --foreground 240 "Checking out '$_base'"
    git checkout "$_base" || {
      _ui_error "Could not checkout '$_base'"
      return 1
    }
  fi

  # Fresh pull
  gum style --foreground 240 "Pulling latest '$_base'"
  git pull --ff-only origin "$_base" || {
    _ui_error "git pull failed — fast-forward only; resolve divergence first"
    return 1
  }

  # Create feature branch off the freshly-pulled base
  gum style --bold --foreground 212 "arh feature -p $_base $_name"
  arh feature -p "$_base" "$_name" || {
    _ui_error "Failed to create branch '$_name'"
    return 1
  }

  local _created
  _created=$(git rev-parse --abbrev-ref HEAD)
  _ui_success "
Created feature branch: $_created
"
  arh -p
}
