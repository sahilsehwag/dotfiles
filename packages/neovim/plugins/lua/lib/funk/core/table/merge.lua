local merge_lists = Funk.curry(function(l1, l2)
	local result = {}
	for i, v in ipairs(l1) do
		result[i] = v
	end
	for i, v in ipairs(l2) do
		result[#result+1] = v
	end
	return result
end)

local merge_dicts = Funk.curry(function(d1, d2)
	local result = {}
	for k, v in pairs(d1) do
		result[k] = v
	end
	for k, v in pairs(d2) do
		result[k] = v
	end
	return result
end)

return Funk.if_else(
  Funk.is_dict,
  merge_dicts,
  merge_lists
)
