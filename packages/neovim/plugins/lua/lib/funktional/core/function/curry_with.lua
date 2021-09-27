-- BUG: handle nil values in arg /vararg
return function(with_fn, fn)
	local meta      = debug.getinfo(with_fn)
	local n_args    = meta.nparams
	local is_vararg = meta.isvararg

	local function curried(...)
		local args = {...}

		if #args > n_args then
			return fn(unpack(args))
		elseif #args == n_args and is_vararg == false then
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
