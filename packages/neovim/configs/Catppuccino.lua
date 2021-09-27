require('catppuccino').setup({
	colorscheme = 'dark_catppuccino',
	transparency = true,
	term_colors = false,
	styles = {
		comments  = 'NONE',
		functions = 'NONE',
		keywords  = 'NONE',
		strings   = 'NONE',
		variables = 'NONE',
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			styles = {
				errors = 'NONE',
				hints = 'NONE',
				warnings = 'NONE',
				information = 'NONE'
			}
		},
		lsp_trouble = true,
		lsp_saga = true,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = true,
		},
		which_key = true,
		indent_blankline = false,
		dashboard = false,
		neogit = true,
		vim_sneak = true,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = true,
	},
})

vim.cmd [[ colorscheme catppuccino ]]
