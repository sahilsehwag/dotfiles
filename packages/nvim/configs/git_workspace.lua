require'git_workspace'.setup{
	workspaces = {
		'~/Documents/projects/work',
		'~/Documents/projects/personal/github',
	}
}

vim.cmd [[
	nnoremap <silent> <Leader>gpP :lua require'git_workspace'.switch_project()<cr>
	nnoremap <silent> <Leader>gpw :lua require'git_workspace'.switch_workspace()<cr>
	nnoremap <silent> <Leader>gpr :lua require'git_workspace'.cd_workspace_root()<cr>
]]

vim.keymap.set('n', '<Leader>gpp', function()
	require'git_workspace'.switch_project{
		prompt = 'Open project in nvim',
		on_select = function(project)
			F.vim.open_nvim_in_tmux{pwd=project}
		end
	}
end, { noremap = true, silent = true })
