require("debugprint").setup()

F.vim.nmap('g?d', function()
		require'debugprint'.deleteprints()
	end
)
