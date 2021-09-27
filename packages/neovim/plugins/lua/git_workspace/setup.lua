__GIT_WORKSPACE = {}

return function(config)
  __GIT_WORKSPACE = {
    current_workspace = nil,
    config = F.concat(
      F.rt('git_workspace.config'),
      config or {}
    ),
  }
end
