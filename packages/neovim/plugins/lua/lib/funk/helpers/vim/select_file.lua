return Funk.curry(function(opts, files)
  local prompt = (
    opts.prompt or
    'Select file'
  )
  local on_select = (
    opts.on_select or
    Funk.vim.on_select('e')
  )

  vim.ui.select(files, {
    prompt = prompt,
    format_item = opts.format_item,
  }, on_select)
end)
