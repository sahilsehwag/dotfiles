local get_project        = F.rf('mani.utils.get_project')
local get_projects       = F.rf('mani.utils.get_projects')
local render_directories = F.rf('mani.renderers.render_directories')
local get_curr_workspace = F.rf('mani.utils.get_current_workspace')

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
        get_curr_workspace() .. '/' .. get_project(project).Path
      )
    end
  end
  config.on_select = on_select

  render_directories(config, get_projects())
end
