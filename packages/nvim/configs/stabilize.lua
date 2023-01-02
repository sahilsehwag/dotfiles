require('stabilize').setup({
	force = true,
	forcemark = nil,
	ignore = {
		filetype = {
			'help',
			'list',
			'Trouble',
		},
		buftype = {
			'terminal',
			'quickfix',
			'loclist',
		},
	},
	nested = nil,
})
