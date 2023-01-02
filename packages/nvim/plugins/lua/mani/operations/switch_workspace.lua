local get_ws = F.rf('mani.utils.get_workspaces')
local render = F.rf('mani.renderers.render_directories')

return F.pipe(
  get_ws,
  render({
    prompt = 'Switch workspace',
    on_select = function(workspace)
      if workspace then
        __MANI.current_workspace = workspace
        F.vim.cd(workspace)
      end
    end
  })
)
