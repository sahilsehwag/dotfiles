return function(n, fn)
	local function curried(...)
		local args = {...}

		if #args >= n then
			return fn(unpack(args))
		else
			return function(...)
				local new_args = {}
				for _, v in ipairs(args) do
					new_args[#new_args + 1] = v
				end
				for _, v in ipairs({...}) do
					new_args[#new_args + 1] = v
				end
				return curried(unpack(new_args))
			end
		end
	end

	return curried
end
