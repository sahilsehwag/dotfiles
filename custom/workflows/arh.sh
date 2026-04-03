#!/usr/bin/env bash

# ==========================================
# ARH REVIEW
# ==========================================
# Reuses helpers from arc.sh:
#   _ui_header, _ui_success, _ui_warn, _ui_error, _ui_confirm, _run_step
#   _ensure_git_repo, _branch_exists

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
