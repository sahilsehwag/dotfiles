__MANI = {}

local default = { workspaces = {} }

return function(config)
  __MANI = {
    current_workspace = nil,
    config = F.concat(default, config or {}),
  }
end
