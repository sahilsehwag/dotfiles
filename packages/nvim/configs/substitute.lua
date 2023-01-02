require'substitute'.setup{
	on_substitute = nil,
	yank_substituted_text = false,
	range = {
		prefix = 's',
		prompt_current_text = false,
		confirm = false,
		complete_word = false,
		motion1 = false,
		motion2 = false,
		suffix = '',
	},
	exchange = {
		motion = false,
	},
}

vim.keymap.set('n', 's',  '<cmd>lua require("substitute").operator()<cr>', { noremap = true })
vim.keymap.set('n', 'ss', '<cmd>lua require("substitute").line()<cr>',     { noremap = true })
vim.keymap.set('n', 'S',  '<cmd>lua require("substitute").eol()<cr>',      { noremap = true })
vim.keymap.set('x', 's',  '<cmd>lua require("substitute").visual()<cr>',   { noremap = true })

vim.keymap.set('n', 'sx',  '<cmd>lua require("substitute.exchange").operator()<cr>', { noremap = true })
vim.keymap.set('n', 'sxx', '<cmd>lua require("substitute.exchange").line()<cr>',     { noremap = true })
vim.keymap.set('x', 'X',   '<cmd>lua require("substitute.exchange").visual()<cr>',   { noremap = true })
vim.keymap.set('n', 'sxc', '<cmd>lua require("substitute.exchange").cancel()<cr>',   { noremap = true })
