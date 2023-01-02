return function()
	return vim.fn.split(
		vim.fn.system('git ls-files --deleted --exclude-standard'),
		'\n'
		)
end
