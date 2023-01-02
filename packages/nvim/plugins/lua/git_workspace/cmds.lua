return {
  list_projects = function()
    return 'git-workspace --workspace ' .. F.rf('git_workspace.utils.get_current_workspace')() .. ' list'
  end
}
