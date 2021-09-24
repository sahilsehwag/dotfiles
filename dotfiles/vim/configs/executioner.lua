require('executioner').setup({
	cmds = { window = 'e', terminal = 'split|terminal' }
})

vim.cmd [[
	nnoremap <silent> <Leader>lfc <cmd>lua require('executioner').compile{}<cr>
	nnoremap <silent> <Leader>lfe <cmd>lua require('executioner').run{}<cr>
	nnoremap <silent> <Leader>lfq <cmd>lua require('executioner').compile_run{}<cr>
	nnoremap <silent> <Leader>lfr <cmd>lua require('executioner').repl{}<cr>
	nnoremap <silent> <Leader>lft <cmd>lua require('executioner').test{}<cr>
	nnoremap <silent> <Leader>lff <cmd>lua require('executioner').format{}<cr>
	nnoremap <silent> <Leader>lfl <cmd>lua require('executioner').lint{}<cr>

	nnoremap <silent> <Leader>lgS <cmd>lua require('executioner').edit_source_file{}<cr>
	nnoremap <silent> <Leader>lgT <cmd>lua require('executioner').edit_test_file{}<cr>
	nnoremap <silent> <Leader>lgF <cmd>lua require('executioner').edit_fixture_file{}<cr>
]]
