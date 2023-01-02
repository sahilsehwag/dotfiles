return Funk.curry(function(split_sep, join_sep)
	return Funk.pipe(
		Funk.split(split_sep),
		Funk.join(join_sep)
	)
end)
