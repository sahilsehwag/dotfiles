local cmds = require('worktree.commands')
local get_branches = require('worktree.helpers.get_branches')
local get_worktree_branches = require('worktree.helpers.get_worktree_branches')

local remove_remote_path = F.pipe(
	F.split('remotes/origin/'),
	F.head
)

local get_cmd = function(force)
	return function(branch)
		return F.join(' ', {
			cmds.cd_to_root(), '&& (',
			cmds.delete_branch(branch, force), ';',
			cmds.add_worktree(branch),
			')',
		})
	end
end

local run_cmd = require('worktree.helpers.get_runner')()

return function(force)
	local wt_branches = get_worktree_branches()
	local strip_remote = function(b) return b:match('remotes/origin/(.+)') or b end
	local available = F.filter(
		function(b) return not F.has(strip_remote(b), wt_branches) end
	)(get_branches())
	require('worktree.helpers.select_branch')(
		'Add worktree: ',
		F.pipe(
			remove_remote_path,
			get_cmd(force),
			run_cmd
		),
		available
	)
end
