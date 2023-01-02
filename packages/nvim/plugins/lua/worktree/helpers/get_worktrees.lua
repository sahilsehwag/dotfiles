return function()
  return F.sh.run_and_split(
    require('worktree.commands').get_worktrees
  )
end
