require'specs'.setup({
	show_jumps	= true,
	min_jump = 30,
	popup = {
		delay_ms = 0, -- delay before popup displays
		inc_ms = 10, -- time increments used for fade/resize effects
		blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
		width = 10,
		winhl = "PMenu",
		fader = require('specs').linear_fader,
		resizer = require('specs').shrink_resizer
	},
	ignore_filetypes = {},
	ignore_buftypes = {
		nofile = true,
	},
})

-- Press <C-b> to call specs!
--vim.api.nvim_set_keymap('n', '<C-b>', ':lua require("specs").show_specs()', { noremap = true, silent = true })

-- You can even bind it to search jumping and more, example:
F.nvim.nmap('n', 'n:lua require("specs").show_specs()<CR>')
F.nvim.nmap('N', 'N:lua require("specs").show_specs()<CR>')
