return Funk.pipe(
	Funk.concat('tmux new-session -c ' .. vim.fn.getcwd() .. ' '),
  Funk.sh.run
)
