local get_cmd = require('worktree.commands').get_worktrees
local runner  = require('worktree.helpers.get_runner')()

return function()
	runner(get_cmd())
end
