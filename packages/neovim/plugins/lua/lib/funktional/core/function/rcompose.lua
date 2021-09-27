return function(...)
	local fns = {...}
	return function(...)
		local args = {...}
		for i = #fns, 1, -1 do
			args = { fns[i](unpack(args)) }
		end
    return unpack(args)
	end
end

