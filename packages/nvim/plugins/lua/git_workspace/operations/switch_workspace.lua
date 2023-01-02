local get_workspaces = F.rf('git_workspace.utils.get_workspaces')
local render_directories = F.rf('git_workspace.renderers.render_directories')

return F.pipe(
  get_workspaces,
  render_directories({
    prompt = 'Switch workspace',
    on_select = function(workspace)
      if workspace then
        __GIT_WORKSPACE.current_workspace = workspace
      end
    end
  })
)
