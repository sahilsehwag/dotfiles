return function()
	return vim.fn.split(
		vim.fn.system('git ls-files --modified --exclude-standard'),
		'\n'
		)
end
