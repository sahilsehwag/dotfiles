local cmd = 'git branch --all --color=never'

local parse_branch = F.pipe(
	F.split(''),
	F.nth(1)
)

local gt1 = F.pipe(F.len, F.gt(1))

return function()
	return F.pipe(
		F.sh.run_and_split,
		F.map(parse_branch),
		F.filter(gt1)
	)(cmd)
end
