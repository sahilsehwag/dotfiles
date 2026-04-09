#!/usr/bin/env bash

# Reuses helpers from arc.sh:
#   _ui_header, _ui_success, _ui_warn, _ui_error, _ui_confirm, _run_step
#   _ensure_git_repo, _branch_exists

# ==========================================
# ARH FEATURE TREE
# ==========================================

arh-feature-tree() {

  _ensure_git_repo || return 1
  command -v arh >/dev/null || { _ui_error "Missing dependency: arh"; return 1; }

  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  [[ "$current_branch" == "HEAD" ]] && {
    _ui_error "Detached HEAD — checkout a branch first"
    return 1
  }

  _ui_header "ARH FEATURE TREE"

  local root_parent
  root_parent=$(gum input --placeholder "$current_branch" --prompt "Root parent branch > ")
  root_parent="${root_parent:-$current_branch}"

  git show-ref --verify --quiet "refs/heads/$root_parent" || {
    _ui_error "Branch '$root_parent' does not exist"
    return 1
  }

  local raw_input
  raw_input=$(gum write \
    --header "Rooted at '$root_parent'  |  indent = child  |  Ctrl+D to confirm" \
    --placeholder "feat-auth
  feat-auth-ui
  feat-auth-api
feat-payments
  feat-payments-stripe" \
    --width 60 \
    --height 15 \
    --show-line-numbers \
    --show-help)

  [[ -z "${raw_input// }" ]] && { _ui_warn "No input provided."; return 0; }

  # Pass 1: collect non-empty lines with their indent column (tabs -> 2 spaces)
  local -a node_names=()
  local -a node_parents=()
  local -a _lines=()
  local -a _cols=()
  while IFS= read -r _line; do
    _line="${_line//$'\t'/  }"
    local _rest="${_line#"${_line%%[! ]*}"}"
    [[ -z "${_rest// }" ]] && continue
    local _col=$(( ${#_line} - ${#_rest} ))
    local _bname="${_rest%"${_rest##*[![:space:]]}"}"
    [[ -z "$_bname" ]] && continue
    _lines+=("$_bname")
    _cols+=("$_col")
  done <<< "$raw_input"

  # Pass 2: for each node scan backward for nearest line with smaller indent = parent
  # O(n^2) but fine for typical tree sizes; avoids bash/zsh array-indexing divergence
  local _nlines="${#_lines[@]}"
  local _i _j
  for (( _i = 1; _i <= _nlines; _i++ )); do
    local _bname="${_lines[$_i]}"
    local _bcol="${_cols[$_i]}"
    local _parent="$root_parent"
    for (( _j = _i - 1; _j >= 1; _j-- )); do
      if (( _cols[$_j] < _bcol )); then
        _parent="${_lines[$_j]}"
        break
      fi
    done
    node_names+=("$_bname")
    node_parents+=("$_parent")
  done

  [[ ${#node_names[@]} -eq 0 ]] && { _ui_warn "No branches parsed."; return 0; }

  # Recursive tree printer — zsh dynamic scoping gives _aft_node access to
  # node_names/node_parents/root_parent from the calling function's frame
  _aft_node() {
    local _nn="$1" _dd="$2" _ind="" _jj _sz
    for (( _jj = 0; _jj < _dd; _jj++ )); do _ind+="  "; done
    (( _dd == 0 )) \
      && printf "  %s\n" "${_ind}${_nn}" \
      || printf "  %s+-- %s\n" "${_ind}" "${_nn}"
    _sz="${#node_names[@]}"
    for (( _jj = 1; _jj <= _sz; _jj++ )); do
      [[ "${node_parents[$_jj]}" == "$_nn" ]] && _aft_node "${node_names[$_jj]}" $(( _dd + 1 ))
    done
  }

  echo ""
  gum style --bold --foreground 212 "Parsed tree:"
  _aft_node "$root_parent" 0
  echo ""

  gum confirm "Create this feature tree?" || return 0

  # Run arh feature directly (not via gum spin) so output is visible.
  # arh prepends UBER_LDAP_UID to branch names, so after each creation we capture
  # the actual branch name and use it when resolving parents for subsequent branches.
  local _total="${#node_names[@]}"
  local -a _actual=()   # _actual[k] = real branch name created for node_names[k]
  local _k
  for (( _k = 1; _k <= _total; _k++ )); do
    local _bname="${node_names[$_k]}"
    local _bparent_typed="${node_parents[$_k]}"

    # Resolve typed parent name -> actual branch name created by arh
    local _bparent_actual="$_bparent_typed"
    local _pi
    for (( _pi = 1; _pi < _k; _pi++ )); do
      if [[ "${node_names[$_pi]}" == "$_bparent_typed" ]]; then
        _bparent_actual="${_actual[$_pi]}"
        break
      fi
    done

    gum style --bold --foreground 212 "[$_k/$_total] arh feature -p $_bparent_actual $_bname"
    arh feature -p "$_bparent_actual" "$_bname" || {
      _ui_error "Failed to create branch '$_bname'"
      return 1
    }

    local _created
    _created=$(git rev-parse --abbrev-ref HEAD)
    _actual+=("$_created")
    gum style --foreground 240 "  -> $_created"
  done

  _ui_success "
Feature tree created
"
  arh -p
}

# ==========================================
# ARH REVIEW
# ==========================================

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
