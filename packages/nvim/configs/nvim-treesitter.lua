--neoorg
--require('nvim-treesitter.parsers').get_parser_configs().norg = {
--  install_info = {
--    url = "https://github.com/vhyrro/tree-sitter-norg",
--    files = { "src/parser.c" },
--    branch = "main"
--  },
--}

require('nvim-treesitter.configs').setup({
	ensure_installed = 'all',
	ignore_install = { "ipkg" },
	highlight = { enable = true, },
	indent = { enable = false, },
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				--general
				['<space>i/'] = "@comment.inner",
				['<space>a/'] = "@comment.outer",
				['<space>is'] = "@statement.inner",
				['<space>as'] = "@statement.outer",
				['<space>ib'] = "@block.inner",
				['<space>ab'] = "@block.outer",
				['<space>il'] = "@loop.inner",
				['<space>al'] = "@loop.outer",
				['<space>ic'] = "@conditional.inner",
				['<space>ac'] = "@conditional.outer",

				['<space>if'] = "@function.inner",
				['<space>af'] = "@function.outer",
				['<space>i('] = "@call.inner",
				['<space>a('] = "@call.outer",
				['<space>i,'] = "@parameter.inner",
				['<space>a,'] = "@parameter.outer",

				["<space>aC"] = "@class.outer",
				["<space>iC"] = "@class.inner",

				--html
				["<space>ix"] = "@attribute.inner",
				["<space>ax"] = "@attribute.outer",
				["<space>it"] = "@tag.inner",
				["<space>at"] = "@tag.outer",

				--js
				["<space>im"] = "@import.inner",
				["<space>am"] = "@import.outer",
				["<space>ik"] = "@key.inner",
				["<space>ak"] = "@key.outer",
				["<space>iv"] = "@value.inner",
				["<space>av"] = "@value.outer",

				["<space>iL"] = "@lhs.inner",
				["<space>aL"] = "@lhs.outer",
				["<space>iR"] = "@rhs.inner",
				["<space>aR"] = "@rhs.outer",

				["<space>id"] = "@declaration.inner",
				["<space>ad"] = "@declaration.outer",

				["<space>ir"] = "@rule.inner",
				["<space>ar"] = "@rule.outer",
			},
		},
		move = {
			enable = true,
			goto_next_start = {
				[']<space>s'] = "@statement.inner",
				[']<space>S'] = "@statement.outer",
				[']<space>b'] = "@block.inner",
				[']<space>B'] = "@block.outer",
				[']<space>l'] = "@loop.inner",
				[']<space>L'] = "@loop.outer",
				[']<space>c'] = "@conditional.inner",
				[']<space>C'] = "@conditional.outer",
				[']<space>f'] = "@function.inner",
				[']<space>F'] = "@function.outer",
				[']<space>a'] = "@call.inner",
				[']<space>A'] = "@call.outer",
				[']<space>p'] = "@parameter.inner",
				[']<space>P'] = "@parameter.outer",
				[']<space>/'] = "@comment.inner",
				[']<space>?'] = "@comment.outer",
			},
			goto_previous_start = {
				['[<space>s'] = "@statement.inner",
				['[<space>S'] = "@statement.outer",
				['[<space>b'] = "@block.inner",
				['[<space>B'] = "@block.outer",
				['[<space>l'] = "@loop.inner",
				['[<space>L'] = "@loop.outer",
				['[<space>c'] = "@conditional.inner",
				['[<space>C'] = "@conditional.outer",
				['[<space>f'] = "@function.inner",
				['[<space>F'] = "@function.outer",
				['[<space>('] = "@call.inner",
				['[<space>)'] = "@call.outer",
				['[<space>,'] = "@parameter.inner",
				['[<space><'] = "@parameter.outer",
				['[<space>/'] = "@comment.inner",
				['[<space>?'] = "@comment.outer",
			},
			goto_next_end = {},
			goto_previous_end = {},
		},
		swap = {
			enable = true,
			keymaps = {},
		},
	},
	textsubjects = {
		enable = false,
		keymaps = {
			['.'] = 'textsubjects-smart',
			[';'] = 'textsubjects-container-outer',
		}
	},
	element_textobject = {
		enable = false,
		keymaps = {
		},
	},
	scope_textobject = {
		enable = false,
		keymaps = {
		},
	},
	pairs = {
		enable = false,
		disable = {},
		highlight_pair_events = {},                                 -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
		highlight_self = false,                                     -- whether to highlight also the part of the pair under cursor (or only the partner)
		goto_right_end = false,                                     -- whether to go to the end of the right partner or the beginning
		fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
		keymaps = {
			goto_partner = "<leader>%",
		},
	},
	autopairs = {
		enable = true,
	},
	refactor = {
		highlight_definitions = { enable = false },
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
				goto_next_usage = "<C-]>",
				goto_previous_usage = "<C-[>",
				--list_definitions = "<Leader>lsD",
				--list_definitions_toc = "<Leader>lsd",
			},
		},
	},
	autotag = {
		enable = true,
		filetypes = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'vue' }
	},
	rainbow = { enable = true, },
	tree_docs = {
		enable = false,
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,       -- Debounced time for highlighting nodes in the playground from source code
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
		lint_events = { "BufWrite", "CursorHold" },
	},
})

vim.cmd [[ set foldmethod=expr ]]
vim.cmd [[ set foldexpr=nvim_treesitter#foldexpr() ]]
