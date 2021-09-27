return Funk.curry(function(opts, files)
  local prompt = (
    opts.prompt or
    'Select file'
  )
  local on_select = (
    opts.on_select or
    Funk.nvim.on_select('e')
  )

  vim.ui.select(files, {
    prompt = prompt,
    format_item = opts.format_item,
  }, on_select)
end)
