return function()
	local lines = F.sh.run_and_split('git worktree list')
	local branches = {}
	for _, line in ipairs(lines) do
		local branch = line:match('%[(.-)%]')
		if branch then
			table.insert(branches, branch)
		end
	end
	return branches
end
