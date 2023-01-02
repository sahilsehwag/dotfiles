vim.cmd [[
	augroup FASD_ADD_ON_CD
		autocmd!
		autocmd DirChanged * lua require('fasd.utilities.add_paths')({ vim.fn.getcwd() })
	augroup END
]]
