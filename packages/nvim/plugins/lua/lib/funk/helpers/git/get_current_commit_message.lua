return function()
	return vim.fn.substitute(
		vim.fn.system('git log -1 --pretty=%B'),
		'\n', '',
		'g'
		)
end
