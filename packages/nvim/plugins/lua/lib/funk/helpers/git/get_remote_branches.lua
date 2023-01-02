return function()
	return vim.fn.substitute(
		vim.fn.system('git branch -r'),
		'\n', '',
		'g'
		)
end
