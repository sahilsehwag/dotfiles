require'mani'.setup{
	workspaces = {
		'~/Documents/projects/personal',
		'~/Documents/projects/work',
	},
}

vim.cmd [[
	nnoremap <silent> <Leader>gPe :lua require'mani'.edit_config()<cr>
	nnoremap <silent> <Leader>gPs :lua require'mani'.sync_projects()<cr>
	nnoremap <silent> <Leader>gPP :lua require'mani'.switch_project()<cr>
	nnoremap <silent> <Leader>gPw :lua require'mani'.switch_workspace()<cr>
	nnoremap <silent> <Leader>gPr :lua require'mani'.cd_workspace_root()<cr>
	nnoremap <silent> <Leader>gPt :lua require'mani'.run_task()<cr>
	nnoremap <silent> <Leader>gPc :lua require'mani'.exec_cmd()<cr>
]]

vim.keymap.set('n', '<Leader>gPp', function()
	require'mani'.switch_project{
		prompt = 'Open project in nvim',
		on_select = function(project)
			F.vim.open_nvim_in_tmux{pwd=project}
		end
	}
end, { noremap = true, silent = true })
