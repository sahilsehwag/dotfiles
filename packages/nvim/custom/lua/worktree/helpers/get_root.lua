return function()
	return F.pipe(
		require('worktree.helpers.get_worktrees'),
		F.head
	)()
end
