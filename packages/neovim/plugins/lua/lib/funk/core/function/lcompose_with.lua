return function(fn)
	return Funk.pipe(
		Funk.of,
		Funk.map(Funk.call(fn)),
		Funk.apply(Funk.lcompose)
	)
end

