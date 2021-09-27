return Funk.curry(function(default, user)
	local config = user or default
	setmetatable(config, {
		__index = default,
	})
	return config
end)
