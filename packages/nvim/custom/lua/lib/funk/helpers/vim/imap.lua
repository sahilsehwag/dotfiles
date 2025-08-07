return function(lhs, rhs, opts)
  vim.keymap.set(
    'i',
    lhs,
    rhs,
		F.concat({
			silent = false,
			noremap = true,
		}, opts or {})
  )
end
