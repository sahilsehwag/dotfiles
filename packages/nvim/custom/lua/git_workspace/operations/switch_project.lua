local get_projects       = F.rf('git_workspace.utils.get_projects')
local render_directories = F.rf('git_workspace.renderers.render_directories')
local get_curr_workspace = F.rf('git_workspace.utils.get_current_workspace')

local default = {
  prompt = 'Switch to project',
  on_select = F.vim.cd,
}

return function(config)
  config = F.vim.get_config(default, config or {})
  local handler = config.on_select
  config.on_select = function(project)
    if project then
      handler(
        get_curr_workspace() .. '/' .. project
      )
    end
  end

  render_directories(config, get_projects())
end
