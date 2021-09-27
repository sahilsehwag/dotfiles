local function search (key, parents)
	for i = 1, #parents do
		local v = parents[i][key]
		if v then
			return v
		end
	end
end

return function (type, parents)
	local Class = {}

	setmetatable(Class, {__index = function (_, key)
		return search(key, parents)
	end})

	Class.__index = Class
	Class.__type = type

	function Class:new (o)
		o = o or {}
		setmetatable(o, Class)
		return o
	end

	return Class
end
