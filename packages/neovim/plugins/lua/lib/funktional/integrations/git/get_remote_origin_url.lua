return function()
	return vim.fn.substitute(
		vim.fn.system('git config --get remote.origin.url'),
		'\n', '',
		'g'
		)
end
