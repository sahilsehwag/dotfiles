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

				--treesitter-frontend-textobjects
				--["ax"] = "@attribute.outer",
				--["ix"] = "@attribute.inner",

				--["am"] = "@import.outer",
				--["im"] = "@import.inner",

				--["a,"] = "@lhs.outer",
				--["i,"] = "@lhs.inner",
				--["a."] = "@rhs.outer",
				--["i."] = "@rhs.inner",

				--["ad"] = "@declaration.outer",
				--["id"] = "@declaration.inner",

				--["ar"] = "@rule.outer",
				--["ir"] = "@rule.inner",

				--["af"] = "@function.outer",
				--["if"] = "@function.inner",
				--["aC"] = "@class.outer",
				--["iC"] = "@class.inner",
				--["ac"] = "@call.outer",
				--["ic"] = "@call.inner",

				--["a;"] = "@block.outer",
				--["i;"] = "@block.inner",

				--["ak"] = "@key.outer",
				--["ik"] = "@key.inner",
				--["av"] = "@value.outer",
				--["iv"] = "@value.inner",
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
	--	enable = true,
	--},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			--toggle_query_editor = 'o',
			--toggle_hl_groups = 'i',
			--toggle_injected_languages = 't',
			--toggle_anonymous_nodes = 'a',
			--toggle_language_display = 'I',
			--focus_language = 'f',
			--unfocus_language = 'F',
			--update = 'R',
			--goto_node = '<cr>',
			--show_help = '?',
		},
	},
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = {"BufWrite", "CursorHold"},
	},
	pairs = {
		enable = true,
		disable = {},
		highlight_pair_events = {}, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
		highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
		goto_right_end = false, -- whether to go to the end of the right partner or the beginning
		fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
		keymaps = {
			goto_partner = "<leader>%",
		},
	},
}

vim.cmd [[ set foldmethod=expr ]]
vim.cmd [[ set foldexpr=nvim_treesitter#foldexpr() ]]
