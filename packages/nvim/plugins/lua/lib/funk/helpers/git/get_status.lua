return function()
	return Funk.pipe(
		Funk.sh.run,
		Funk.split('\n'),
		Funk.split_each('\\s\\+')
		)('git status --porcelain')
end
