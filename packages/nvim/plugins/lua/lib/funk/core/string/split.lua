return Funk.curry(function(separator, str)
	return vim.fn.split(str, separator)
end)
