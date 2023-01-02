vim.keymap.set(
	{ 'n', 'v', 'i' },
	'<M-E>',
	function()
		F.sh.run(
			string.format(
				[[tmux new-window -c '#{pane_current_path}' 'vifm %s']],
				vim.fn.expand('%:p:h')
			)
		)
	end
)
