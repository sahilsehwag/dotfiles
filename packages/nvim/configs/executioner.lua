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

F.vim.nmap('<Leader>lfc', function() require('executioner').compile{} end)
F.vim.nmap('<Leader>lfq', function() require('executioner').compile_run{} end)
F.vim.nmap('<Leader>lfr', function() require('executioner').repl{} end)
F.vim.nmap('<Leader>lft', function() require('executioner').test{} end)
F.vim.nmap('<Leader>lff', function() require('executioner').format{} end)
F.vim.nmap('<Leader>lfl', function() require('executioner').lint{} end)

F.vim.nmap('<Leader>lgS', function() require('executioner').edit_source_file{} end)
F.vim.nmap('<Leader>lgT', function() require('executioner').edit_test_file{} end)
F.vim.nmap('<Leader>lgF', function() require('executioner').edit_fixture_file{} end)

F.vim.nmap('<Leader>lfe', function()
  require('executioner').run{
    FT_X_RUNNER = {
      mkdc = function()
        vim.cmd('MarkdownPreview')
      end,
			markdown  = function()
        vim.cmd('MarkdownPreview')
      end,
    },
  }
end)

vim.cmd [[ command! ExecutionerFormat lua require('executioner').format{} ]]

--vim.cmd [[ autocmd BufWritePre *.js  lua require('executioner').format{} ]]
--vim.cmd [[ autocmd BufWritePre *.ts  lua require('executioner').format{} ]]
--vim.cmd [[ autocmd BufWritePre *.jsx lua require('executioner').format{} ]]
--vim.cmd [[ autocmd BufWritePre *.tsx lua require('executioner').format{} ]]

--vim.cmd [[ autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html lua require('executioner').format{} ]]
