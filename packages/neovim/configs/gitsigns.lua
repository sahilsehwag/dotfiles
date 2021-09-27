require('gitsigns').setup({
	signs = {
		-- add          = {hl = 'JatAddFG',          text = ' █', numhl='', linehl='JatAddFG'},
		-- change       = {hl = 'JatChangeFG',       text = ' █', numhl='', linehl='JatChangeFG'},
		-- delete       = {hl = 'JatDeleteFG',       text = ' ', numhl='', linehl='JatDeleteFG'},
		-- topdelete    = {hl = 'JatDeleteFG',       text = ' ', numhl='', linehl='JatDeleteFG'},

		add          = {hl = 'JatAddFG',          text = '▎', numhl='', linehl='JatAddFG'},
		change       = {hl = 'JatChangeFG',       text = '▎', numhl='', linehl='JatChangeFG'},
		delete       = {hl = 'JatDeleteFG',       text = '▎', numhl='', linehl='JatDeleteFG'},
		topdelete    = {hl = 'JatDeleteFG',       text = '▎', numhl='', linehl='JatDeleteFG'},
		changedelete = {hl = 'JatChangeDeleteFG', text = '~', numhl='', linehl='JatChangeDeleteFG'},

		-- add          = {hl = 'JatAddFG',          text = '▋', numhl='', linehl='JatAddFG'},
		-- change       = {hl = 'JatChangeFG',       text = '▋', numhl='', linehl='JatChangeFG'},
		-- delete       = {hl = 'JatDeleteFG',       text = '▋', numhl='', linehl='JatDeleteFG'},
		-- topdelete    = {hl = 'JatDeleteFG',       text = '▋', numhl='', linehl='JatDeleteFG'},
		-- changedelete = {hl = 'JatChangeDeleteFG', text = '~', numhl='', linehl='JatChangeDeleteFG'},
	},
	numhl = false,
	linehl = false,
	keymaps = {
		-- Default keymap options
		noremap = true,
		buffer = true,

		['n ]g'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
		['n [g'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

		['n <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		['n <leader>ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		['n <leader>ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

		-- Text objects
		['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
		['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
	},
	watch_gitdir = {
		interval = 1000
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
  diff_opts = {
    internal = true,
  },
})
