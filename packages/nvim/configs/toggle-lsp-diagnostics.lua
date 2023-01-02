require'toggle_lsp_diagnostics'.init({
	--virtual_text = {
	--  prefix = "◼",
	--  spacing = 4,
	--},
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})

vim.cmd [[
	nmap <leader>letu <Plug>(toggle-lsp-diag-underline)
	nmap <leader>lets <Plug>(toggle-lsp-diag-signs)
	nmap <leader>letv <Plug>(toggle-lsp-diag-vtext)
	nmap <leader>leti <Plug>(toggle-lsp-diag-update_in_insert)
	nmap <leader>let. <Plug>(toggle-lsp-diag)
]]
