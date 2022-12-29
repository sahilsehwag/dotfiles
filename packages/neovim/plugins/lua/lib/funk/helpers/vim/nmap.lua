return function(lhs, rhs, opts)
  vim.keymap.set('n', lhs, rhs, F.concat({
    silent = true,
  }, opts or {}))
end
