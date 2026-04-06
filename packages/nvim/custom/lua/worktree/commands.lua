return {
	cd_to_root = function()
		return 'cd ' .. require('worktree.helpers.get_root')()
	end,
	get_worktrees = F.always('git worktree list | choose 0'),
	delete_branch = function(branch, force)
		return 'git branch -d ' .. branch .. (force and ' --force' or '')
	end,
	add_worktree = function(name, branch)
		local root = require('worktree.helpers.get_root')()
		local repo = root:match('([^/]+)$')
		return 'git worktree add -b ' .. name .. ' ../worktrees/' .. repo .. '/' .. name .. ' ' .. branch
	end,
	add_worktree_with_name = function(branch)
		local root = require('worktree.helpers.get_root')()
		local repo = root:match('([^/]+)$')
		return 'git worktree add ../worktrees/' .. repo .. '/' .. branch .. ' ' .. branch
	end,
	remove_worktree = function(worktree, force)
		return 'git worktree remove ' .. worktree .. (force and ' --force' or '')
	end,
}
