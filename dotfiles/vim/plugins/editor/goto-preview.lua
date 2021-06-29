require('goto-preview').setup({
	width = 180;
	height = 30;
	default_mappings = false;
	opacity = nil;
	post_open_hook = nil;
	debug = false;
})

vim.cmd [[nnoremap <leader>lpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>]]
vim.cmd [[nnoremap <leader>lpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>]]
vim.cmd [[nnoremap <leader>lpq <cmd>lua require('goto-preview').close_all_win()<CR>]]

vim.cmd [[nnoremap gp <cmd>lua require('goto-preview').goto_preview_definition()<CR>]]
vim.cmd [[nnoremap gP <cmd>lua require('goto-preview').goto_preview_implementation()<CR>]]
