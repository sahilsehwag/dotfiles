local default = {}

return function(config)
  config = F.nvim.get_config(default, config)
end
