return function()
	return vim.fn.substitute(
		vim.fn.system('git rev-parse --show-toplevel'),
		'\n', '',
		'g'
		)
end
