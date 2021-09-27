local cmds = require('worktree.commands')

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
	require('worktree.helpers.select_branch')(
		'Add worktree: ',
		F.pipe(
      remove_remote_path,
			get_cmd(force),
			run_cmd
		)
	)
end
