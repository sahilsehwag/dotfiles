local cmds = require('worktree.commands')

local get_cmd = function(force)
	-- TODO: curry not working properly
	return function(worktree)
		return F.join(' ', {
			cmds.cd_to_root(), '&&',
			cmds.remove_worktree(worktree, force),
		})
	end
end

local run_cmd = require('worktree.helpers.get_runner')()

return function(force)
	require('worktree.helpers.select_worktree')(
		'Remove worktree: ',
		F.pipe(
			get_cmd(force),
			run_cmd
		)
	)
end
