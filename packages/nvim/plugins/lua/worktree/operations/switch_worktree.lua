return function()
	require('worktree.helpers.select_worktree')(
		'Switch worktree: ',
		function(worktree)
			vim.api.nvim_command('cd ' .. worktree)
		end
	)
end
