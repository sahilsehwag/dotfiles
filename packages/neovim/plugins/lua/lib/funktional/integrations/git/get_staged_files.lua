return function()
	return vim.fn.split(
		vim.fn.system('git diff --name-only --staged'),
		'\n'
		)
end
