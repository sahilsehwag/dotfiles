require('trevj').setup({
	containers = {
		lua = {
			table_constructor = {
				final_separator = ',',
				final_end_line = true,
			},
			arguments = {
				final_separator = false,
				final_end_line = true,
			},
			parameters = {
				final_separator = false,
				final_end_line = true,
			},
		},
		html = {
			start_tag = {
				final_separator = false,
				final_end_line = true,
				skip = {tag_name = true},
			},
		},
	},
})

vim.api.nvim_set_keymap(
  'n', 'gS',
  '<cmd>lua require("trevj").format_at_cursor()<CR>',
  {noremap = true, silent = true}
)

