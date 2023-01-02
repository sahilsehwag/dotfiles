vim.cmd [[
	augroup ON_CD
		autocmd!
		autocmd DirChanged * lua vim.notify('PWD ' .. vim.fn.getcwd())
	augroup END
]]
