return {
	line = function()
		return vim.fn.substitute(
			vim.fn.getline(vim.v.foldstart),
			'\t',
			vim.fn['repeat'](' ', vim.o.tabstop),
			'g'
		)
	end,
	percentage = function()
		local lines_in_fold = 1 + vim.v.foldend - vim.v.foldstart
		local total_lines = vim.fn.line('$')
		return lines_in_fold / total_lines * 100
	end,
	level = function()
		return vim.v.foldlevel
	end,
	size = function()
		return 1 + vim.v.foldend - vim.v.foldstart
	end,
}
