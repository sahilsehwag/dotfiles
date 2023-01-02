return F.curry(function(opts, directories)
  opts.prompt = opts.prompt or 'Select directory'
  opts.on_select = opts.on_select or F.vim.cd

  vim.ui.select(directories, {
    prompt = prompt,
    format_item = opts.format_item,
  }, opts.on_select)
end)
