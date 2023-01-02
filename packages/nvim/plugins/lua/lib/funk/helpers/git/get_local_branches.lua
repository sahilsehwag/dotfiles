return function()
	local branches = vim.fn.substitute(
		vim.fn.system('git branch --list --color=never'),
		'\n', '',
		'g'
		)
	local local_branches = {}
	for branch in string.gmatch(branches, '%S+') do
		if branch ~= 'HEAD' then
			table.insert(local_branches, branch)
		end
	end
	return local_branches
end
