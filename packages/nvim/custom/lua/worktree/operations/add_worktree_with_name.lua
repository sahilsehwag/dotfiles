local cmds = require('worktree.commands')

local remove_remote_path = F.pipe(
	F.split('remotes/origin/'),
	F.head
)

local get_cmd = function(branch)
	return function(name)
		return F.join(' ', {
			cmds.cd_to_root(), '&&',
			cmds.add_worktree(name, branch),
		})
	end
end

local run_cmd = require('worktree.helpers.get_runner')()

return function()
	require('worktree.helpers.select_branch')(
		'Add worktree (base branch): ',
		F.pipe(
			remove_remote_path,
			function(branch)
				vim.ui.input({ prompt = 'Worktree name: ' }, function(name)
					if name and name ~= '' then
						run_cmd(get_cmd(branch)(name))
					end
				end)
			end
		)
	)
end
