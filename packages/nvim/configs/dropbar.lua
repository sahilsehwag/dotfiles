require('dropbar').setup({
	bar = {
		update_events = {
			buf = {
				-- BufModifiedSet removed in nvim nightly; use TextChanged instead
				'FileChangedShellPost',
				'TextChanged',
				'ModeChanged',
			},
		},
	},
})
