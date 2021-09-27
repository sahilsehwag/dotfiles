return Funk.pipe(
	function(path)
		return path .. '/.git'
	end,
	Funk.any_pass(
		Funk.pipe(vim.fn.isdirectory,  Funk.eq(1)),
		Funk.pipe(vim.fn.filereadable, Funk.eq(1))
	)
)

