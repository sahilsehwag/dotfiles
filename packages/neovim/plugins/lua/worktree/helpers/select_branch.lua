local get_branches = require("worktree.helpers.get_branches")

return function(prompt, on_ok)
	vim.ui.select(get_branches(), {
		prompt = prompt,
	}, function(option)
		if option then
			on_ok(option)
		end
	end)
end
