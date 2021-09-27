return function()
	return vim.fn.split(
		vim.fn.system('git ls-files --unmerged --exclude-standard'),
		'\n'
		)
end
