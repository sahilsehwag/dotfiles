return Funk.pipe(
	Funk.concat('tmux split-window -h -c ' .. vim.fn.getcwd() .. ' '),
  Funk.sh.run
)
