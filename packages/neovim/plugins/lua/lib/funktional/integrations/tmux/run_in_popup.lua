-- TODO: cwd not working
return Funk.pipe(
	Funk.concat('tmux display-popup -d ' .. vim.fn.getcwd() .. ' '),
  Funk.sh.run
)
