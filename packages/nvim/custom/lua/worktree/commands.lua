return {
	cd_to_root = function()
		return 'cd ' .. require('worktree.helpers.get_root')()
	end,
	get_worktrees = F.always('git worktree list | choose 0'),
	delete_branch = function(branch, force)
		return 'git branch -d ' .. branch .. (force and ' --force' or '')
	end,
	add_worktree = function(branch)
		return 'git worktree add branches/' .. branch .. ' ' .. branch
	end,
	remove_worktree = function(worktree, force)
		return 'git worktree remove ' .. worktree .. (force and ' --force' or '')
	end,
}
