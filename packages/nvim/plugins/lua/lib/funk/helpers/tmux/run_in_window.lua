return Funk.pipe(
	Funk.concat('tmux new-window -c ' .. vim.fn.getcwd() .. ' '),
	Funk.sh.run
)
