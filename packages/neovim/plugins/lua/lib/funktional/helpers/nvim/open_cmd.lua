local default = {
  pwd = vim.fn.getcwd(),
}

return function(config)
  return Funk.pipe(
    Funk.nvim.get_config(default),
    function(cfg)
      return 'nvim --cmd "cd ' .. cfg.pwd .. '"'
    end
  )(config or {})
end
