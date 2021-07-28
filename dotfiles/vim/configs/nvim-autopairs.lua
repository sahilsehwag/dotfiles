local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

require('nvim-autopairs').setup({
	disable_filetype = {
		'TelescopePrompt',
		'vim',
	},
	ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
	enable_moveright = true,
	enable_afterquote = true,
	enable_check_bracket_line = true,
	disabled_blockwise_mode = true,
	check_ts = true,
	map_bs = true,
})

require("nvim-autopairs.completion.compe").setup({
	map_cr = true,
	map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
	auto_select = false,	-- auto select first item
	map_char = { -- modifies the function or method delimiter by filetypes
		all = '(',
		tex = '{'
	}
})

--require("nvim-autopairs.completion.cmp").setup({
--  map_cr = true, --  map <CR> on insert mode
--  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
--  auto_select = true, -- automatically select the first item
--  insert = false, -- use insert confirm behavior instead of replace
--  map_char = { -- modifies the function or method delimiter by filetypes
--    all = '(',
--    tex = '{'
--  }
--})

--coq_nvim
--completion.nvim
