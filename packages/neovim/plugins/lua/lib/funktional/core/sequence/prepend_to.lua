local function prepend_to_str(org, str)
	return str .. org
end

local function prepend_to_list(list, value)
	local output = { value }
	for _, v in ipairs(list) do
		output[#output + 1] = v
	end
	return output
end

return Funk.switch(
	{ Funk.is_string, Funk.curry(prepend_to_str) },
	{ Funk.is_list, Funk.curry(prepend_to_list) }
)
