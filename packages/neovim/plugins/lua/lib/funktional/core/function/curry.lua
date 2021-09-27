return function(fn)
	return Funk.curry_with(fn, fn)
end
