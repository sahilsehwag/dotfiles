--set for javascript project filetypes json/js/jsx/ts/tsx
vim.cmd [[
	augroup NpmScripts
		autocmd! NpmScripts
		autocmd Filetype javascript,javascriptreact,typescript,typescriptreact,json nnoremap <buffer> <silent> <LocalLeader>p <cmd>lua require('npm_scripts').run_script('project')<cr>
		autocmd Filetype javascript,javascriptreact,typescript,typescriptreact,json nnoremap <buffer> <silent> <LocalLeader>w <cmd>lua require('npm_scripts').run_script('workspace')<cr>
		autocmd Filetype javascript,javascriptreact,typescript,typescriptreact,json nnoremap <buffer> <silent> <LocalLeader>b <cmd>lua require('npm_scripts').run_script('buffer')<cr>
		autocmd Filetype javascript,javascriptreact,typescript,typescriptreact,json nnoremap <buffer> <silent> <LocalLeader>s <cmd>lua require('npm_scripts').switch_workspace()<cr>
	augroup end
]]

	--vim.cmd [[ nnoremap <silent> <Leader>l<LocalLeader>p <cmd>lua require('npm_scripts').run_script('project')<cr> ]]
	--vim.cmd [[ nnoremap <silent> <Leader>l<LocalLeader>w <cmd>lua require('npm_scripts').run_script('workspace')<cr> ]]
	--vim.cmd [[ nnoremap <silent> <Leader>l<LocalLeader>b <cmd>lua require('npm_scripts').run_script('buffer')<cr> ]]
	--vim.cmd [[ nnoremap <silent> <Leader>l<LocalLeader>s <cmd>lua require('npm_scripts').switch_workspace()<cr> ]]
