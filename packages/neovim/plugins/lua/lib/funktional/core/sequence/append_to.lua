local function append_to_str(org, str)
	return org .. str
end

local function append_to_list(list, value)
	local output = {}
	for _, v in ipairs(list) do
		output[#output + 1] = v
	end
	output[#output + 1] = value
	return output
end

return Funk.switch(
	{ Funk.is_string, Funk.curry(append_to_str) },
	{ Funk.is_list, Funk.curry(append_to_list) }
)
