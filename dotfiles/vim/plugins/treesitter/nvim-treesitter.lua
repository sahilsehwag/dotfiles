require'nvim-treesitter.configs'.setup {
	highlight = { enable = true, },
	indent = { enable = false, },
	rainbow = { enable = true, },
	textobjects = {
		select = {
			enable = true,
			keymaps = { },
		},
		move = {
			enable = true,
			keymaps = { },
		},
		swap = {
			enable = true,
			keymaps = { },
		},
	},
	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = false },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "<Leader>lsR",
			},
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gd",
				goto_next_usage = "<A-]>",
				goto_previous_usage = "<A-[>",
				--list_definitions = "<Leader>lsD",
				--list_definitions_toc = "<Leader>lsd",
			},
		},
	},
	autotag = {
		enable = true,
		filetypes = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'vue' }
	},
	context_commentstring = {
    enable = true,
  },
}

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
