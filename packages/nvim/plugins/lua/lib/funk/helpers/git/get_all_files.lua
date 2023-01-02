return function()
	return vim.fn.split(
		vim.fn.system('git ls-files --exclude-standard'),
		'\n'
	)
end
