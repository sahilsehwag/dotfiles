require('goto-preview').setup({
	width = 120;
	height = 15;
	default_mappings = false;
	lsp_configs = {
		lua = {
			get_config = function(data)
				return data.targetUri,{ data.targetRange.start.line + 1, data.targetRange.start.character }
			end
		};
		typescript = {
			get_config = function(data)
				return data.uri, { data.range.start.line + 1, data.range.start.character }
			end
		}
	}
})

vim.cmd [[nnoremap <leader>lpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>]]
vim.cmd [[nnoremap <leader>lpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>]]
vim.cmd [[nnoremap <leader>lP <cmd>lua require('goto-preview').close_all_win()<CR>]]
