#!/usr/bin/env bash

# set -o pipefail   # intentionally disabled

# ==========================================
# CONFIG
# ==========================================

ARC_MAIN_BRANCH="main"
ARC_BRANCH_PREFIX="arcpatch-"


# ==========================================
# UI HELPERS
# ==========================================

_ui_header() {
  gum style \
    --border rounded \
    --padding "1 2" \
    --bold \
    --foreground 212 \
    "$1"
}

_ui_success() {
  gum style --bold --foreground 42 "$1"
}

_ui_warn() {
  gum style --foreground 214 "$1"
}

_ui_error() {
  gum style --foreground 196 "$1"
}

_ui_confirm() {
  gum confirm "$1"
}

# Spinner runner with step counter
_run_step() {
  local index="$1"
  local total="$2"
  local title="$3"
  local cmd="$4"

  gum spin \
    --spinner dot \
    --title "[$index/$total] $title" \
    -- bash -c "$cmd"
}

# ==========================================
# SAFETY HELPERS
# ==========================================

_ensure_git_repo() {
  git rev-parse --abbrev-ref HEAD >/dev/null 2>&1 || {
    _ui_error "❌ Not inside a git repository"
    return 1
  }
}

_branch_exists() {
  git show-ref --verify --quiet "refs/heads/$1"
}

# ==========================================
# WORKSPACE STATE MANAGEMENT
# ==========================================

_workspace_save() {

  ORIGINAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  STASHED=false

  if [ -n "$(git status --porcelain)" ]; then
    _run_step "$1" "$2" "Stashing local changes" \
      "git stash save '$STASH_MESSAGE'" || return 1
    STASHED=true
  fi
}

_workspace_restore() {

  if [ -n "${ORIGINAL_BRANCH:-}" ]; then
    git checkout "$ORIGINAL_BRANCH" >/dev/null 2>&1 || true
  fi

  if [ -n "${ARC_PATCH_BRANCH:-}" ] && _branch_exists "$ARC_PATCH_BRANCH"; then
    git branch -D "$ARC_PATCH_BRANCH" >/dev/null 2>&1 || true
  fi

  if [ "$STASHED" = true ]; then
    _run_step "$1" "$2" "Restoring stash" \
      "git stash pop 'stash^{/$STASH_MESSAGE}' || echo '⚠️ Stash preserved due to conflicts'"
  fi
}

# ==========================================
# ARC REVIEW
# ==========================================

arc-review() {

  _ensure_git_repo || return 1

  if [ -z "${1:-}" ]; then
    _ui_error "Usage: arc-review D12345"
    return 1
  fi

  local REV="$1"
  local TOTAL_STEPS=6

  STASH_MESSAGE="review-stash-$REV"
  ARC_PATCH_BRANCH=""

  _ui_header "ARC REVIEW — $REV"

  _rollback_review() {
    _ui_warn "⚠️ Rolling back review environment"
    git reset --hard >/dev/null 2>&1 || true
    _workspace_restore "$TOTAL_STEPS" "$TOTAL_STEPS"
  }

  # Step 1 — Save workspace
  _workspace_save 1 "$TOTAL_STEPS" || {
    _rollback_review
    return 1
  }

  # Step 2 — Checkout main
  _run_step 2 $TOTAL_STEPS "Checkout $ARC_MAIN_BRANCH" \
    "git checkout $ARC_MAIN_BRANCH" || {
      _rollback_review
      return 1
    }

  # Step 3 — Arc patch
  _run_step 3 $TOTAL_STEPS "Applying arc patch" \
    "arc patch $REV" || {
      _rollback_review
      return 1
    }

  ARC_PATCH_BRANCH=$(git rev-parse --abbrev-ref HEAD)

  if [[ ! "$ARC_PATCH_BRANCH" == $ARC_BRANCH_PREFIX* ]]; then
    _ui_error "Unexpected branch created: $ARC_PATCH_BRANCH"
    _rollback_review
    return 1
  fi

  # Step 4 — Mixed reset
  _run_step 4 $TOTAL_STEPS "Reset commit for editor diff" \
    "git reset --mixed HEAD~1" || {
      _rollback_review
      return 1
    }

  _ui_success "
✅ Review environment ready

Patch branch : $ARC_PATCH_BRANCH
Original     : $ORIGINAL_BRANCH
"

  _ui_confirm "Finish review and cleanup?" || return 0

  # Step 5 — Clean review branch
  _run_step 5 $TOTAL_STEPS "Cleaning review branch" \
    "git reset --hard" || {
      _rollback_review
      return 1
    }

  # Step 6 — Restore workspace
  _workspace_restore 6 "$TOTAL_STEPS"

  _ui_success "
🎉 Review workflow completed successfully
"
}

# ==========================================
# ARC REBASE
# ==========================================

arc-rebase() {

  _ensure_git_repo || return 1

  if [ -z "${1:-}" ]; then
    _ui_error "Usage: arc-rebase D12345"
    return 1
  fi

  local REV="$1"
  local TOTAL_STEPS=8

  STASH_MESSAGE="rebase-stash-$REV"
  ARC_PATCH_BRANCH=""

  _ui_header "ARC REBASE — $REV"

  _rollback_rebase() {
    _ui_warn "⚠️ Rolling back rebase environment"
    git rebase --abort >/dev/null 2>&1 || true
    git reset --hard >/dev/null 2>&1 || true
    _workspace_restore "$TOTAL_STEPS" "$TOTAL_STEPS"
  }

  # Step 1 — Save workspace
  _workspace_save 1 "$TOTAL_STEPS" || {
    _rollback_rebase
    return 1
  }

  # Step 2 — Checkout main
  _run_step 2 $TOTAL_STEPS "Checkout $ARC_MAIN_BRANCH" \
    "git checkout $ARC_MAIN_BRANCH" || {
      _rollback_rebase
      return 1
    }

  # Step 3 — Arc patch
  _run_step 3 $TOTAL_STEPS "Applying arc patch" \
    "arc patch $REV" || {
      _rollback_rebase
      return 1
    }

  ARC_PATCH_BRANCH=$(git rev-parse --abbrev-ref HEAD)

  if [[ ! "$ARC_PATCH_BRANCH" == $ARC_BRANCH_PREFIX* ]]; then
    _ui_error "Unexpected branch created: $ARC_PATCH_BRANCH"
    _rollback_rebase
    return 1
  fi

  # Step 4 — Rebase
  if ! _run_step 4 $TOTAL_STEPS "Rebasing onto origin/main" \
    "git rebase origin/main"; then

    _ui_warn "
⚠️ Rebase conflicts detected

Resolve conflicts manually:
  git status
"

    _ui_confirm "Conflicts resolved and ready to continue?" || return 1

    _run_step 5 $TOTAL_STEPS "Staging resolved files" \
      "git add -A" || {
        _rollback_rebase
        return 1
      }

    _run_step 6 $TOTAL_STEPS "Continuing rebase" \
      "git rebase --continue" || {
        _rollback_rebase
        return 1
      }
  fi

  # Step 7 — Run checks
	_run_step 7 $TOTAL_STEPS "Running pre diff checks" \
		"ucheck"

  # Step 8 — Restore workspace
  _workspace_restore 8 "$TOTAL_STEPS"

  _ui_success "
🎉 Rebase workflow completed successfully
"
}

# ==========================================
# ARC LAND
# ==========================================

arc-land() {

  _ensure_git_repo || return 1

  if [ -z "${1:-}" ]; then
    _ui_error "Usage: arc-land D12345"
    return 1
  fi

  local REV="$1"
  local TOTAL_STEPS=7

  _ui_header "ARC LAND — $REV"

  _run_step 1 $TOTAL_STEPS "Fetch origin/main" \
    "git fetch origin main" || return 1

  _run_step 2 $TOTAL_STEPS "Applying arc patch" \
    "arc patch '$REV'" || return 1

  if ! _run_step 3 $TOTAL_STEPS "Rebasing onto origin/main" \
    "git rebase origin/main"; then

    _ui_warn "
⚠️ Rebase conflict detected

Resolve manually:
  git rebase --continue
"

    _ui_confirm "Rebase resolved?" || return 1
  fi

  _run_step 4 $TOTAL_STEPS "jz install" "jz install" || return 1
  _run_step 5 $TOTAL_STEPS "jz typecheck" "jz typecheck" || return 1

  _run_step 6 $TOTAL_STEPS "jz lint" "jz lint --fix" || return 1
  _run_step 7 $TOTAL_STEPS "jz test" "jz test" || return 1

  _ui_confirm "Proceed with arc diff + land?" || return 0

  _run_step 7 $TOTAL_STEPS "arc diff" "arc diff" || return 1
  _run_step 7 $TOTAL_STEPS "arc land" "arc land" || return 1

  _ui_success "
🎉 Land workflow completed successfully
"
}
