return Funk.curry(function(sep, list)
	return Funk.map(
		Funk.split(sep),
		list
	)
end)
