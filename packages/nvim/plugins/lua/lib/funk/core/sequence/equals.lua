local are_lists_equal = function(l1, l2)
	if #l1 ~= #l2 then
		return false
	end

	return Funk.all(
		Funk.map(function(v1, i)
			return v1 == l2[i]
		end, l1)
	)
end

local are_dicts_equal = function(d1, d2)
	if Funk.len(d1) ~= Funk.len(d2) then
		return false
	end

	return Funk.all(
		Funk.fold(function(acc, x, k)
			return acc and x == d2[k]
		end, true, d1)
	)
end

return Funk.if_else(
	Funk.is_list,
	Funk.curry(are_lists_equal),
	Funk.curry(are_dicts_equal)
)

