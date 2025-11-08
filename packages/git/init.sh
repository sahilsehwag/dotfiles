alias gpom="git pull origin main"
alias grom="git fetch origin main && git rebase origin/main && jz install"

# arcinist (arc)
arc-review(){
	# --- Configuration ---
  # Set your repository's main branch name (e.g., "main", "master", "develop")
  local main_branch="main"
  # ---------------------

  if [ -z "$1" ]; then
    echo "Usage: arc-review <RevisionID>"
    echo "Example: arc-review D12345"
    return 1
  fi

  local revision_id=$1
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -z "$current_branch" ]; then
    echo "Error: Not a git repository."
    return 1
  fi

  local review_branch="review-$revision_id"
  local stash_message="reviewdiff-stash-for-$revision_id"
  local stashed=false

  echo "Starting review for $revision_id..."

  # 1. Stash current work if there are any changes
  if [ -n "$(git status --porcelain)" ]; then
    echo "Stashing current changes..."
    git stash save "$stash_message"
    stashed=true
  fi

  # 2. Go to main branch and create the temporary review branch
  echo "Switching to $main_branch to create review branch..."
  if ! git checkout $main_branch; then
    echo "Error: Could not check out $main_branch."
    # Try to restore stash if we created one
    if [ "$stashed" = true ]; then git stash pop; fi
    return 1
  fi

  # Optional: Pull latest changes to ensure patch applies cleanly
  # echo "Pulling latest changes on $main_branch..."
  # git pull origin $main_branch

  if ! git checkout -b $review_branch; then
    echo "Error: Could not create branch $review_branch."
    echo "Returning to $current_branch."
    git checkout $current_branch
    if [ "$stashed" = true ]; then git stash pop; fi
    return 1
  fi

  # 3. Apply the patch
  echo "Applying patch $revision_id..."
  if ! arc patch $revision_id; then
    echo "Error: 'arc patch $revision_id' failed."
    echo "Cleaning up and returning to $current_branch..."
    git checkout $current_branch
    git branch -D $review_branch
    if [ "$stashed" = true ]; then git stash pop; fi
    return 1
  fi

  # Perform a mixed reset to show changes in the editor's git gutter
  echo "Resetting branch to show staged changes (for editor review)..."
  if ! git reset --mixed HEAD~1; then
    echo "Warning: 'git reset --mixed' failed. Changes will remain committed."
    # We don't need to exit here, just warn the user.
  fi

  # 4. Wait for the user to finish their review
  echo ""
  echo "--------------------------------------------------------"
  echo "✅ Successfully checked out $revision_id on branch $review_branch."
  echo "You are now on the review branch. You can browse, build, and test."
  echo "All your original work is safely stashed."
  echo ""

  # Use shell-specific prompt for read
  if [ -n "$ZSH_VERSION" ]; then
    # Zsh-compatible prompt
    read "?Press [Enter] to finish your review and clean up..."
  else
    # Bash-compatible prompt
    read -p "Press [Enter] to finish your review and clean up..."
  fi

  echo ""

  # 5. Clean up
  echo "Cleaning up..."

  # Force reset the review branch to avoid "dirty" working tree errors
  # This is safe because this branch is temporary and about to be deleted.
  echo "Cleaning the working directory"
  git reset --hard

  if ! git checkout $current_branch; then
     echo "Warning: Could not check out $current_branch. Staying on $review_branch."
     echo "You will need to manually clean up."
     return 1
  fi

  echo "Deleted temporary branch $review_branch."
  git branch -D $review_branch

  if [ "$stashed" = true ]; then
    echo "Restoring stashed changes..."
    # We use 'apply' instead of 'pop' just in case of a conflict,
    # so the stash isn't dropped automatically.
    if git stash apply "stash^{/$stash_message}"; then
      git stash drop "stash^{/$stash_message}"
    else
      echo "Warning: Could not automatically apply stash. Your changes are still in the stash."
    fi
  fi

  echo "--------------------------------------------------------"
  echo "✅ Review complete. You are back on $current_branch."
  echo "--------------------------------------------------------"
}

arc-land() {
  # 1. Check if a diff revision argument is provided
  if [ -z "$1" ]; then
    echo "Error: No diff revision number provided."
    echo "Usage: patch_rebase_land <revision_number>"
    return 1
  fi

  local diff_revision=$1

  # 2. Execute the workflow, stopping if any command fails (due to '&&')
  echo ">>> Fetching latest origin/main..."
  git fetch origin main && \

  echo ">>> Patching $diff_revision..."
  arc patch "$diff_revision" && \

  echo ">>> Rebasing onto origin/main..."
  git rebase origin/main

  # Check the exit status of the rebase
  if [ $? -ne 0 ]; then
    echo "-------------------------------------------------------------------"
    echo ">>> REBASE FAILED: Conflicts likely detected."
    echo "Please fix the conflicts in another terminal."
    echo "After fixing, run 'git rebase --continue'."
    echo "Once the rebase is *fully completed*, return here and press Enter."
    echo "-------------------------------------------------------------------"
  else
    echo "-------------------------------------------------------------------"
    echo ">>> Rebase successful."
    echo "If you need to make any other changes, do so now."
    echo "When ready, press Enter to proceed to 'arc diff' and 'arc land'..."
    echo "-------------------------------------------------------------------"
  fi

  # 3. Pause for the manual step (Fix conflicts, commit)
  # The user must press Enter to continue.
  # Use shell-specific prompt for read
  if [ -n "$ZSH_VERSION" ]; then
    # Zsh-compatible prompt
    read "?Press [Enter] to continue after resolving conflicts"
  else
    # Bash-compatible prompt
    read -p "?Press [Enter] to continue after resolving conflicts"
  fi

  # 4. Run pre-diff checks (jz)
  echo ">>> Running 'jz inst'..."
  jz install && \

  echo ">>> Running 'jz typecheck'..."
  jz typecheck && \

  echo ">>> Running 'jz lint --fix'..."
  jz lint --fix && \

  echo ">>> Running 'jz test'..."
  jz test && \

  # 5. Continue with arc diff and arc land
  echo ">>> Running 'arc diff'..."
  arc diff &&\

  echo ">>> Running 'arc diff'..."
  arc land

  if [ $? -eq 0 ]; then
    echo ">>> Workflow completed successfully."
  else
    echo ">>> 'arc diff' failed."
  fi
}

alias arc-fresh="git checkout -- ./flipr && git checkout main && git pull origin main && git rebase && jz install && jz update-flipr"

