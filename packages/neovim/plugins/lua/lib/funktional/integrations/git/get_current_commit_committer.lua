return function()
	return vim.fn.substitute(
		vim.fn.system('git log -1 --pretty=%cn'),
		'\n', '',
		'g'
		)
end
