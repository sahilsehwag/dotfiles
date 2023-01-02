return function(lhs, rhs, opts)
	vim.keymap.set(
		"n",
		lhs,
		rhs,
		F.concat({
			silent = true,
			noremap = true,
		}, opts or {})
	)
end
