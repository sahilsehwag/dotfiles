local function get(key, cache)
	for k, v in pairs(cache) do
		if Funk.equals(k, key) then
			return v
		end
	end
end

Funk.CACHE = {}

return function(fn)
	local cache = {}

	local cached_fn = function(...)
		local args = {...}

		local cached = get(args, cache)
		if cached then
			return cached
		end

		cache[args] = fn(...)
		return cache[args]
	end

  Funk.CACHE[cached_fn] = cache
  return cached_fn
end
