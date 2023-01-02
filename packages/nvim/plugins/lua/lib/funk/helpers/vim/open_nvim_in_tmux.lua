return Funk.pipe(
	Funk.vim.open_cmd,
	Funk.tmux.run_in_window
)
