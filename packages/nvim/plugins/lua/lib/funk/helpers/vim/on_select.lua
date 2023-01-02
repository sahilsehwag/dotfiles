return function(cmd)
  return Funk.if_else(
    Funk.is_nil,
    Funk.noop,
    Funk.pipe(
      Funk.concat(cmd .. ' '),
      vim.api.nvim_command
    )
  )
end
