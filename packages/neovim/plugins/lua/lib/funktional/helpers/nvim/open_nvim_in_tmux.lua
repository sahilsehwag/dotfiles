return Funk.pipe(
  Funk.nvim.open_cmd,
  Funk.tmux.run_in_window
)
