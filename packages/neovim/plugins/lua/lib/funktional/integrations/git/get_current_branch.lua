return function()
	return vim.fn.substitute(
		vim.fn.system('git rev-parse --abbrev-ref HEAD'),
		'\n', '',
		'g'
		)
end
