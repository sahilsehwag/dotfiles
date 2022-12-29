return function(with_key, fn)
	local cache = {}
	return function(...)
		local key = with_key(fn, {...})

		if cache[key] then
			return cache[key]
		end

		cache[key] = fn(...)
		return cache[key]
	end
end
