local get_expansion_string = require('folder.helpers').get_expansion_string

return function(components)
	local left = table.concat({
		components.line,
		'',
		'[' .. components.level .. ']',
	}, ' ')

	local right = table.concat({
		components.size .. 'L(' .. string.format('%.1f', components.percentage) .. '%)',
	}, ' ')

	local buffer = get_expansion_string(#left + #right, ' ')
	return left .. buffer .. right
end
