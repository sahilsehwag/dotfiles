return Funk.curry(function(opts, directories)
  local prompt = (
    opts.prompt or
    'Select directory'
  )
  local on_select = (
    opts.on_select or
    Funk.vim.on_select('cd')
  )

  local format_item = (
    opts.format_item or
    function(item)
      return vim.fn.fnamemodify(item, ':~')
    end
  )

  vim.ui.select(directories, {
    prompt = prompt,
    format_item = format_item,
  }, on_select)
end)
