return function()
	return vim.fn.split(
		vim.fn.system('git ls-files --others --ignored --exclude-standard'),
		'\n'
		)
end
