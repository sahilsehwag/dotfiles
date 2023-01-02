return function(...)
	local fns = {...}
	return function(...)
		local args = {...}
		for i = 1, #fns do
			args = { fns[i](unpack(args)) }
		end
    return unpack(args)
	end
end

