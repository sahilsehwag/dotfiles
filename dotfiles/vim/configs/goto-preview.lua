require('goto-preview').setup({
	width = 180;
	height = 30;
	default_mappings = false;
	opacity = nil;
	post_open_hook = function(buffer, window)
		vim.api.nvim_buf_set_keymap(buffer, 'n', '<LocalLeader>d', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>'    , {noremap = true})
		vim.api.nvim_buf_set_keymap(buffer, 'n', '<LocalLeader>i', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(buffer, 'n', '<LocalLeader>q', '<cmd>lua require("goto-preview").close_all_win()<CR>'              , {noremap = true})
		vim.api.nvim_buf_set_keymap(buffer, 'n', '<LocalLeader>m', '<cmd>MaximizerToggle<CR>'                                          , {noremap = true})
	end;
	debug = false;
})

vim.cmd [[nnoremap <leader>lpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>]]
vim.cmd [[nnoremap <leader>lpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>]]
vim.cmd [[nnoremap <leader>lpq <cmd>lua require('goto-preview').close_all_win()<CR>]]

vim.cmd [[nnoremap gp <cmd>lua require('goto-preview').goto_preview_definition()<CR>]]
vim.cmd [[nnoremap gP <cmd>lua require('goto-preview').goto_preview_implementation()<CR>]]

--vim.cmd [[nnoremap gP <cmd>lua require('goto-preview').goto_preview_definition()<CR>]]
--vim.cmd [[nnoremap gp <cmd>execute "normal gP wm"<CR>]]

vim.cmd [[command! GotoPreviewDefinition     lua require('goto-preview').goto_preview_definition()]]
vim.cmd [[command! GotoPreviewImplementation lua require('goto-preview').goto_preview_implementation()]]
vim.cmd [[command! GotoPreviewCloseAll       lua require('goto-preview').close_all_win()]]

return {
	extensions = {
		openMaxmizedPreview = function()
			vim.cmd [[ lua require("goto-preview").goto_preview_definition() ]]
			--vim.cmd [[ GotoPreviewDefinition | MaximizerToggle ]]
		end,
	},
}
