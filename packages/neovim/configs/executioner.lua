require('executioner').setup({
	cmds = {
		window = 'e',
		terminal = (
			((vim.fn.exists('neovide') == 1 or os.getenv('TMUX') == nil) and 'AsyncRun -mode=term')
				or (os.getenv('TMUX') ~= nil and 'T lh.h20%')
				or 'AsyncRun -mode=term'
		),
	}
})

local run_vim_runner =
	((vim.fn.exists('neovide') == 1 or os.getenv('TMUX') == nil) and 'AsyncRun -mode=term')
		or (os.getenv('TMUX') ~= nil and 'T lh.h20%.cf')
		or 'AsyncRun -mode=term'

vim.cmd [[
	nnoremap <silent> <Leader>lfc <cmd>lua require('executioner').compile{}<cr>
	nnoremap <silent> <Leader>lfe <cmd>lua require('executioner').run{ vim_runner = run_vim_runner }<cr>
	nnoremap <silent> <Leader>lfq <cmd>lua require('executioner').compile_run{}<cr>
	nnoremap <silent> <Leader>lfr <cmd>lua require('executioner').repl{}<cr>
	nnoremap <silent> <Leader>lft <cmd>lua require('executioner').test{}<cr>
	nnoremap <silent> <Leader>lff <cmd>lua require('executioner').format{}<cr>
	nnoremap <silent> <Leader>lfl <cmd>lua require('executioner').lint{}<cr>

	nnoremap <silent> <Leader>lgS <cmd>lua require('executioner').edit_source_file{}<cr>
	nnoremap <silent> <Leader>lgT <cmd>lua require('executioner').edit_test_file{}<cr>
	nnoremap <silent> <Leader>lgF <cmd>lua require('executioner').edit_fixture_file{}<cr>
]]

--vim.cmd [[ autocmd BufWritePre *.js  lua require('executioner').format{} ]]
--vim.cmd [[ autocmd BufWritePre *.ts  lua require('executioner').format{} ]]
--vim.cmd [[ autocmd BufWritePre *.jsx lua require('executioner').format{} ]]
--vim.cmd [[ autocmd BufWritePre *.tsx lua require('executioner').format{} ]]

--vim.cmd [[ autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html lua require('executioner').format{} ]]
