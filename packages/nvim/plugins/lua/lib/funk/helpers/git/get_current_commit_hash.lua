return function()
	return vim.fn.substitute(
		vim.fn.system('git rev-parse HEAD'),
		'\n', '',
		'g'
		)
end
