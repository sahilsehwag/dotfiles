local is_list = function(tbl)
	if type(tbl) == 'table' then
		return #tbl > 0
	end
	return false
end

local is_dict = function(tbl)
	if type(tbl) == 'table' then
		return #tbl == 0
	end
	return false
end

function merge(dicts)
	local result = {}
	for _, dict in ipairs(dicts) do
		for k,v in pairs(dict) do
			if is_dict(v) and is_dict(result[k] or false) then
				result[k] = merge({result[k] or {}, v})
			else
				result[k] = v
			end
		end
	end
	return result
end

return {
	table = {
		is_list = is_list,
		is_dict = is_dict,
		list = {
			concat = function(lists)
				local result = {}
				for _, list in ipairs(lists) do
					for _,v in ipairs(list) do
						table.insert(result, v)
					end
				end
				return result
			end,
		},
		dict = {
			get_path = function(dict, path)
				local value = dict or {}
				for _, key in ipairs(vim.fn.split(path, '\\.')) do
					if value[key] then
						value = value[key]
					else
						return nil
					end
				end
				return value
			end,
			merge = merge,
		},
	},
}
