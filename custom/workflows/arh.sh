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
# ARH FEATURE TREE DISTRIBUTE
# ==========================================

arh-feature-tree-distribute() {

  _ensure_git_repo || return 1
  command -v arh >/dev/null || { _ui_error "Missing dependency: arh"; return 1; }

  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  [[ "$current_branch" == "HEAD" ]] && {
    _ui_error "Detached HEAD — checkout a branch first"
    return 1
  }

  _ui_header "ARH FEATURE TREE + DISTRIBUTE"

  # ── root parent (tree base, e.g. main) ─────────────────────────────────
  local root_parent
  root_parent=$(gum input --placeholder "main" --prompt "Root parent branch > ")
  root_parent="${root_parent:-main}"
  git show-ref --verify --quiet "refs/heads/$root_parent" || {
    _ui_error "Branch '$root_parent' does not exist"; return 1
  }

  # ── source branch (has commits — stays checked out in main worktree) ───
  local source_branch
  source_branch=$(gum input --placeholder "" --prompt "Source branch (with commits) > ")
  [[ -z "$source_branch" ]] && { _ui_error "Source branch required"; return 1; }
  git rev-parse --verify --quiet "$source_branch" &>/dev/null || {
    _ui_error "Branch '$source_branch' not found"; return 1
  }

  # ── collect commits: source beyond root_parent, oldest → newest ────────
  local -a _cshas=() _cmsgs=()
  local merge_base
  merge_base=$(git merge-base "$source_branch" "$root_parent" 2>/dev/null)

  if [[ -n "$merge_base" ]]; then
    while IFS= read -r _l; do
      [[ -z "$_l" ]] && continue
      _cshas+=("${_l%% *}")
      _cmsgs+=("$_l")
    done < <(git log --oneline --reverse "$merge_base..$source_branch")
  else
    while IFS= read -r _l; do
      [[ -z "$_l" ]] && continue
      _cshas+=("${_l%% *}")
      _cmsgs+=("$_l")
    done < <(git log --oneline --reverse -30 "$source_branch")
  fi

  local total_commits=${#_cshas[@]}

  if [[ $total_commits -eq 0 ]]; then
    _ui_warn "No commits on '$source_branch' beyond '$root_parent'"
    return 0
  fi

  echo ""
  gum style --bold --foreground 212 "$total_commits commits on '$source_branch' (oldest → newest):"
  local _ci
  for (( _ci = 1; _ci <= ${#_cmsgs[@]}; _ci++ )); do
    printf "  $(tput setaf 141)#%-3d$(tput sgr0) %s\n" "$_ci" "${_cmsgs[$_ci]}"
  done
  echo ""

  # ── tree + commit input ────────────────────────────────────────────────
  local raw_input
  raw_input=$(gum write \
    --header "root: $root_parent  |  source: $source_branch  |  indent=child  |  branch: #N or #N-#M  |  Ctrl+J=newline  Ctrl+D=submit" \
    --placeholder "feat-auth: #1 #2 #3
  feat-auth-ui: #4 #5
  feat-auth-api: #6
feat-payments: #7-#9

── or without commit refs (auto-assigns 1:1) ──
feat-part-1
  feat-part-1a
  feat-part-1b
feat-part-2" \
    --width 80 \
    --height 18 \
    --char-limit 0 \
    --show-line-numbers)

  [[ -z "${raw_input// }" ]] && { _ui_warn "No input."; return 0; }

  # ── pass 1: parse lines → name, indent column, resolved SHAs ──────────
  # Key fix: split branch name from commit refs properly.
  # A token starting with # is ALWAYS a commit ref, never part of the name.
  local -a _lines=() _cols=() _commit_strs=()
  local _has_any_refs=0

  while IFS= read -r _line; do
    _line="${_line//$'\t'/  }"
    local _rest="${_line#"${_line%%[! ]*}"}"
    [[ -z "${_rest// }" ]] && continue
    local _col=$(( ${#_line} - ${#_rest} ))

    local _bname="" _refs=""

    if [[ "$_rest" == *:* ]]; then
      # ── explicit colon separator: left = name, right = refs ──
      _bname="${_rest%%:*}"
      _refs="${_rest#*:}"
    else
      # ── no colon: split on first token that looks like a ref (#N, SHA) ──
      # everything before is branch name, everything from first ref onward is refs
      local -a _tokens=()
      _tokens=(${(z)_rest})
      _bname=""
      _refs=""
      local _found_ref=0
      for _tok in "${_tokens[@]}"; do
        if (( _found_ref )); then
          _refs+="$_tok "
        elif [[ "$_tok" =~ ^\# ]]; then
          _found_ref=1
          _refs+="$_tok "
        elif git rev-parse --verify --quiet "$_tok" &>/dev/null 2>&1 && [[ ${#_tok} -ge 7 ]]; then
          # looks like a SHA (7+ hex chars that git resolves)
          _found_ref=1
          _refs+="$_tok "
        else
          _bname+="${_bname:+ }$_tok"
        fi
      done
    fi

    # trim
    _bname="${_bname#"${_bname%%[! ]*}"}"
    _bname="${_bname%"${_bname##*[![:space:]]}"}"
    [[ -z "$_bname" ]] && continue

    # resolve refs → SHAs
    local -a resolved=()
    for ref in ${(z)_refs}; do
      ref="${ref// }"
      [[ -z "$ref" ]] && continue
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
          _has_any_refs=1
          resolved+=("$(git rev-parse --short "$ref")")
        else
          _ui_warn "Unknown ref '$ref' — skipped"
        fi
      fi
    done

    _lines+=("$_bname")
    _cols+=("$_col")
    _commit_strs+=("${resolved[*]}")
  done <<< "$raw_input"

  local _nlines=${#_lines[@]}
  [[ $_nlines -eq 0 ]] && { _ui_warn "Nothing parsed."; return 0; }

  # ── auto-assign mode: no refs provided anywhere → 1:1 mapping ─────────
  if (( ! _has_any_refs )); then
    if (( _nlines > total_commits )); then
      # more branches than commits — assign what we can, rest get nothing
      _ui_warn "More branches ($_nlines) than commits ($total_commits) — extra branches will be empty"
      for (( _i = 1; _i <= _nlines; _i++ )); do
        if (( _i <= total_commits )); then
          _commit_strs[$_i]="${_cshas[$_i]}"
        else
          _commit_strs[$_i]=""
        fi
      done
    elif (( _nlines < total_commits )); then
      _ui_error "Fewer branches ($_nlines) than commits ($total_commits) — cannot auto-assign"
      _ui_warn "Either add more branches or use explicit refs (#N, #N-#M)"
      return 1
    else
      # exact match — 1:1
      for (( _i = 1; _i <= _nlines; _i++ )); do
        _commit_strs[$_i]="${_cshas[$_i]}"
      done
    fi
    gum style --foreground 99 "Auto-assigned: 1 commit per branch (no explicit refs given)"
  fi

  # ── pass 2: determine parents via indentation scan-back ────────────────
  local -a node_names=() node_parents=() node_commits=()
  local _i _j
  for (( _i = 1; _i <= _nlines; _i++ )); do
    local _parent="$root_parent"
    for (( _j = _i - 1; _j >= 1; _j-- )); do
      if (( _cols[$_j] < _cols[$_i] )); then
        _parent="${_lines[$_j]}"
        break
      fi
    done
    node_names+=("${_lines[$_i]}")
    node_parents+=("$_parent")
    node_commits+=("${_commit_strs[$_i]}")
  done

  # ── preview ────────────────────────────────────────────────────────────
  echo ""
  gum style --bold --foreground 212 "Plan:  root=$root_parent  source=$source_branch"

  _aftd_show() {
    local nn="$1" dd="$2" ind=""
    local _jj _ki
    for (( _jj = 0; _jj < dd; _jj++ )); do ind+="  "; done

    local prefix
    (( dd == 0 )) && prefix="${ind}${nn}" || prefix="${ind}+-- ${nn}"

    local cinfo=""
    for (( _ki = 1; _ki <= ${#node_names[@]}; _ki++ )); do
      if [[ "${node_names[$_ki]}" == "$nn" && -n "${node_commits[$_ki]}" ]]; then
        local wc=$(echo "${node_commits[$_ki]}" | wc -w | tr -d ' ')
        cinfo="  ← $wc commit(s)"
        break
      fi
    done
    printf "  %s%s\n" "$prefix" "$cinfo"

    for (( _ki = 1; _ki <= ${#node_names[@]}; _ki++ )); do
      if [[ "${node_names[$_ki]}" == "$nn" && -n "${node_commits[$_ki]}" ]]; then
        for _s in ${(z)${node_commits[$_ki]}}; do
          printf "  %s    ▸ %s\n" "$ind" "$(git log --oneline -1 "$_s" 2>/dev/null)"
        done
      fi
    done

    for (( _ki = 1; _ki <= ${#node_names[@]}; _ki++ )); do
      [[ "${node_parents[$_ki]}" == "$nn" ]] && _aftd_show "${node_names[$_ki]}" $(( dd + 1 ))
    done
  }

  _aftd_show "$root_parent" 0
  echo ""

  gum confirm "Create tree and distribute?" || return 0

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # EXECUTE — topological order: parents always processed before children
  #
  #   ① checkout parent   → arh creates child from parent's latest state
  #   ② arh feature       → creates & checks out new branch
  #   ③ rebase onto parent → inherits parent's cherry-picks (safety net)
  #   ④ cherry-pick        → apply this branch's own commits
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  local _total=${#node_names[@]}
  local -a _actual=()
  local _k

  for (( _k = 1; _k <= _total; _k++ )); do
    local _bname="${node_names[$_k]}"
    local _bparent="${node_parents[$_k]}"
    local _commits="${node_commits[$_k]}"

    # resolve typed parent → actual branch name arh created
    local _bparent_actual="$_bparent"
    local _pi
    for (( _pi = 1; _pi < _k; _pi++ )); do
      [[ "${node_names[$_pi]}" == "$_bparent" ]] && {
        _bparent_actual="${_actual[$_pi]}"
        break
      }
    done

    echo ""
    gum style --bold --foreground 212 "[$_k/$_total] $_bname"

    # ① checkout parent
    gum style --foreground 240 "  ① checkout $_bparent_actual"
    git checkout "$_bparent_actual" 2>/dev/null || {
      _ui_error "Cannot checkout '$_bparent_actual'"; return 1
    }

    # ② create feature branch
    gum style --foreground 240 "  ② arh feature -p $_bparent_actual $_bname"
    arh feature -p "$_bparent_actual" "$_bname" || {
      _ui_error "Failed to create '$_bname'"; return 1
    }

    local _created
    _created=$(git rev-parse --abbrev-ref HEAD)
    _actual+=("$_created")
    gum style --foreground 240 "    → $_created"

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
      local _cnt=$(echo "$_commits" | wc -w | tr -d ' ')
      gum style --foreground 99 "  ④ cherry-pick $_cnt commit(s)"

      for _s in ${(z)_commits}; do
        gum style --foreground 240 "    ▸ $(git log --oneline -1 "$_s" 2>/dev/null)"

        if ! git cherry-pick "$_s" 2>/dev/null; then
          _ui_error "    conflict on $_s"

          local action
          action=$(gum choose \
            "resolve (fix now)" \
            "skip this commit" \
            "abort everything" \
            --header "How to proceed?" --cursor "▸ ")

          case "$action" in
            resolve*)
              _ui_warn "    fix conflicts, stage, then press Enter…"
              read -r
              git cherry-pick --continue 2>/dev/null || {
                _ui_error "    --continue failed"; return 1
              }
              ;;
            skip*)
              git cherry-pick --skip 2>/dev/null
              _ui_warn "    ⏭ skipped"
              ;;
            abort*)
              git cherry-pick --abort 2>/dev/null
              return 1
              ;;
          esac
        fi
      done
    else
      gum style --foreground 240 "  ④ no commits assigned"
    fi
  done

  echo ""
  _ui_success "Feature tree created and commits distributed!"
  echo ""
  git checkout "$root_parent" 2>/dev/null
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
