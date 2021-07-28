require('executioner').setup({
	cmds = { window = 'e', terminal = 'split|terminal' }
})

vim.cmd [[
	nnoremap <silent> <Leader>lbc <cmd>lua require('executioner').compile{}<cr>
	nnoremap <silent> <Leader>lbe <cmd>lua require('executioner').run{}<cr>
	nnoremap <silent> <Leader>lbq <cmd>lua require('executioner').compile_run{}<cr>
	nnoremap <silent> <Leader>lbr <cmd>lua require('executioner').repl{}<cr>
	nnoremap <silent> <Leader>lbf <cmd>lua require('executioner').format{}<cr>
	nnoremap <silent> <Leader>lbl <cmd>lua require('executioner').lint{}<cr>
]]
