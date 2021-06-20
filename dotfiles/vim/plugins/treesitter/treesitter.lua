require'nvim-treesitter.configs'.setup {
	highlight = { enable = true, },
	indent = { enable = false, },
	rainbow = { enable = true, },
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				['is'] = "@statement.inner",
				['as'] = "@statement.outer",
				['ib'] = "@block.inner",
				['ab'] = "@block.outer",
				['il'] = "@loop.inner",
				['al'] = "@loop.outer",
				['ic'] = "@conditional.inner",
				['ac'] = "@conditional.outer",
				['if'] = "@function.inner",
				['af'] = "@function.outer",
				['ia'] = "@call.inner",
				['aa'] = "@call.outer",
				--['ip'] = "@parameter.inner",
				--['ap'] = "@parameter.outer",
				--['ik'] = "@comment.inner",
				--['ak'] = "@comment.outer",
			},
		},
		move = {
			enable = true,
			goto_next_start = {
				[']s'] = "@statement.inner",
				[']S'] = "@statement.outer",
				[']b'] = "@block.inner",
				[']B'] = "@block.outer",
				[']l'] = "@loop.inner",
				[']L'] = "@loop.outer",
				[']c'] = "@conditional.inner",
				[']C'] = "@conditional.outer",
				[']f'] = "@function.inner",
				[']F'] = "@function.outer",
				[']a'] = "@call.inner",
				[']A'] = "@call.outer",
				[']p'] = "@parameter.inner",
				[']P'] = "@parameter.outer",
				[']k'] = "@comment.inner",
				[']K'] = "@comment.outer",
			},
			goto_previous_start = {
				['[s'] = "@statement.inner",
				['[S'] = "@statement.outer",
				['[b'] = "@block.inner",
				['[B'] = "@block.outer",
				['[l'] = "@loop.inner",
				['[L'] = "@loop.outer",
				['[c'] = "@conditional.inner",
				['[C'] = "@conditional.outer",
				['[f'] = "@function.inner",
				['[F'] = "@function.outer",
				['[a'] = "@call.inner",
				['[A'] = "@call.outer",
				['[p'] = "@parameter.inner",
				['[P'] = "@parameter.outer",
				['[k'] = "@comment.inner",
				['[K'] = "@comment.outer",
			},
			goto_next_end = { },
			goto_previous_end = { },
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
				--goto_definition = "gd",
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
	--tree_docs = {
	--  enable = true,
	--},
}

vim.cmd [[ set foldmethod=expr ]]
vim.cmd [[ set foldexpr=nvim_treesitter#foldexpr() ]]
