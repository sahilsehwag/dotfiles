require('highlight_current_n').setup({
	highlight_group = 'IncSearch' -- highlight group name to use for highlight
})

vim.cmd [[
	nmap n <Plug>(highlight-current-n-n)
	nmap N <Plug>(highlight-current-n-N)
]]
