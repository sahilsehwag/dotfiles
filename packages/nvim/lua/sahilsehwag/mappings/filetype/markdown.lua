vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown,mkdc",
	callback = function()
		F.vim.nmap("<LocalLeader>b", "<cmd>norm ysiW*l.l<CR>")
		F.vim.nmap("<LocalLeader>i", "<cmd>norm ysiW*l<CR>")
		F.vim.nmap("<LocalLeader>`", "<cmd>norm ysiW`l<CR>")

		F.vim.nmap("<LocalLeader>l", "<cmd>norm I* <right><CR>")
		F.vim.nmap("<LocalLeader>c", "<cmd>norm 0a [ ]<right><right><CR>")
		F.vim.nmap("<LocalLeader>C", "<cmd>norm I* [ ] <right><CR>")

		F.vim.nmap("<LocalLeader>1", "<cmd>norm I# <right><CR>")
		F.vim.nmap("<LocalLeader>2", "<cmd>norm I## <right><CR>")
		F.vim.nmap("<LocalLeader>3", "<cmd>norm I### <right><CR>")

		F.vim.nmap("<LocalLeader>-", "<cmd>norm o---<CR>")

		--F.vim.vmap("<LocalLeader>b", "<cmd>norm ysgv*lysi**<CR>")
		--F.vim.vmap("<LocalLeader>i", "<cmd>norm ysgv*l<CR>")
		--F.vim.vmap("<LocalLeader>c", "<cmd>norm ysgv`l<CR>")
	end,
})
