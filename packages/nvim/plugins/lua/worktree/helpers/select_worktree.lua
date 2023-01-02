local get_worktrees = require('worktree.helpers.get_worktrees')
local get_root = require('worktree.helpers.get_root')

return function(prompt, on_ok)
	vim.ui.select(get_worktrees(), {
		prompt = prompt,
		format_item = F.pipe(
			F.split(get_root() .. '/'),
      F.head
		),
	}, function(option)
		if option then
			on_ok(option)
		end
	end)
end
