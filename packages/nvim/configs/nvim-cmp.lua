local cmp = require'cmp'
local luasnip = require('luasnip')

vim.o.completeopt = 'menu,menuone,noselect'

local rtc = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local fk = function(str)
	return vim.api.nvim_feedkeys(str, 'n', true)
end

local fkrtc = function(str)
	fk(rtc(str))
end

local check_backspace = function()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
			--vim.fn["UltiSnips#Anon"](args.body)
			--vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<S-esc>'] = cmp.mapping.close(),
		['<C-Space>'] = cmp.mapping.complete(),

		--['<Tab>'] = function(fallback)
		--	--if vim.fn.pumvisible() == 1 then
		--		--fkrtc('<C-n>')
		--	if cmp.visible() then
		--		cmp.select_next_item()
		--	elseif luasnip and luasnip.expand_or_jumpable() then
		--		fkrtc('<cmd>lua require("luasnip").expand_or_jump()<cr>')
		--	--elseif vim.fn['UltiSnips#CanExpandSnippet']() == 1 or vim.fn['UltiSnips#CanJumpForwards']() == 1 then
		--		--fkrtc('<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>')
		--	--elseif vim.fn.call('vsnip#available', {1}) == 1 then
		--		--fkrtc('<Plug>(vsnip-expand-or-jump)')
		--	elseif check_backspace() then
		--		fkrtc('<Tab>')
		--	else
		--		fallback()
		--	end
		--end,
		--['<S-Tab>'] = function(fallback)
		--	--if vim.fn.pumvisible() == 1 then
		--		--fkrtc('<C-p>')
		--	if cmp.visible() then
		--		cmp.select_prev_item()
		--	elseif luasnip and luasnip.jumpable(-1) then
		--		fkrtc('<cmd>lua require"luasnip".jump(-1)<cr>')
		--	--elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
		--		--fkrtc('<C-R>=UltiSnips#JumpBackwards()<CR>')
		--	--elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
		--		--fkrtc('<Plug>(vsnip-jump-prev)')
		--	else
		--		fallback()
		--	end
		--end,
	},
	sources = {
		{ name = 'luasnip',   max_item_count = 3, priority = 1000000 },
		{ name = 'ultisnips', max_item_count = 3, priority = 1000000 },
		{ name = 'vsnip',     max_item_count = 3, priority = 1000000 },

		{ name = 'nvim_lsp',                max_item_count = nil, },
		{ name = 'nvim_lua',                max_item_count = nil, },
		{ name = 'nvim_lsp_signature_help', max_item_count = 7,  },

		--{ name = 'cmp_ai', max_item_count = 2,  }, -- FIX: not working
		{ name = 'cmp_tabnine', max_item_count = 3, },
		{ name = 'tags',        max_item_count = 3, },
		{ name = 'treesitter',  max_item_count = 3, },

		{ name = 'buffer', max_item_count = 3, },
		{ name = 'tmux',   max_item_count = 3, },
		{ name = 'rg',     max_item_count = 3, },
		{ name = 'path',   max_item_count = 3, },
		{ name = 'zsh',    max_item_count = 3, },
		{ name = 'npm',    max_item_count = 3, },
		{ name = 'git',    max_item_count = 3, },

		{ name = 'look',  keyword_length = 2, max_item_count = 3, },
		{ name = 'calc',  max_item_count = 3, },
		{ name = 'spell', max_item_count = 3, },
		{ name = 'emoji', max_item_count = 3, },
	},
	formatting = {
		format = require('lspkind').cmp_format({with_text = true, menu = ({
			buffer				= '[Buffer]',
			path					= '[Path]',
			nvim_lsp			= '[LSP]',
			nvim_lua			= '[Lua]',
			treesitter		= '[Treesitter]',
			luasnip				= '[LuaSnip]',
			vsnip					= '[VSnip]',
			ultisnips			= '[UltiSnips]',
			tags					= '[Tags]',
			zsh						= '[Zsh]',
			calc					= '[Calculator]',
			spell					= '[Spell]',
			emoji					= '[Emoji]',
			look					= '[Look]',
			cmp_tabnine		= '[Tabnine]',
			latex_symbols = '[Latex]',
			rg						= '[RG]',
			tmux					= '[Tmux]',
			cmp_ai				= '[LLM]',
		})}),
	},
	filetype = {
		gitcommit = {
			sources = cmp.config.sources({
				{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
			}, {
				{ name = 'buffer' },
			})
		},
		typr = {
			sources = {},
		}
	},
	cmdline = {
		['/'] = {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		},
		[':'] = {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		},
	},
})
