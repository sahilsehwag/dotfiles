return function()
	local branches = vim.fn.substitute(
		vim.fn.system('git branch --all --color=never'),
		'\n', '',
		'g'
		)
	local all_branches = {}
	for branch in string.gmatch(branches, '%S+') do
		table.insert(all_branches, branch)
	end
	return all_branches
end
