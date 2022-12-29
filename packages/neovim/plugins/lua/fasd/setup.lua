local default = {
  add_on_cd = true,
}

return function(config)
  config = F.vim.get_config(default, config or {})
  if config.add_on_cd then
    require('fasd.autocmds.add_on_cd')
  end
end
