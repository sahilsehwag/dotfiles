--SETUP
	luasnip = require('luasnip')
	
	local FILETYPES = {
		'typescript',
		'lua',
		'sh',
		'bash',
		'zsh',
		'spectre_panel',
	}
	
	local FILETYPE_X_SNIPPETS = {
		spectre_panel = 'regex',
		zsh = 'sh',
		bash = 'sh',
	}

	luasnip.snippets = {}
	for _, filetype in ipairs(FILETYPES) do
		local config = FILETYPE_X_SNIPPETS[filetype] or filetype
		luasnip.snippets[filetype] = require(vim.g.config.paths.configs .. '/LuaSnip/' .. config)
	end
--MAPPINGS
	--vim.cmd [[ imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<cmd>lua require"luasnip".expand_or_jump()<cr>' : '<Tab>'	]]
	--vim.cmd [[ inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr> ]]

	--vim.cmd [[ snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr> ]]
	--vim.cmd [[ snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr> ]]

	--vim.cmd [[ imap <silent><expr> <C-CR> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-CR>' ]]
	--vim.cmd [[ smap <silent><expr> <C-CR> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-CR>' ]]
--FRIENDLY-SNIPPETS
	-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
	-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
	-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
	-- will need to extend the table yourself instead of setting a new one.

	--require("luasnip/loaders/from_vscode").load({ include = { "python" } }) -- Load only python snippets
	--require("luasnip/loaders/from_vscode").load({ paths = { "./my-snippets" } }) -- Load snippets from my-snippets folder

	-- You can also use lazy loading so you only get in memory snippets of languages you use
	require("luasnip/loaders/from_vscode").lazy_load() -- You can pass { path = "./my-snippets/"} as well
