local get_expansion_string = require('folder.helpers').get_expansion_string

return function(components, args)
	local left_variant = args.left or 'minimal'
	local right_variant = args.right or 'arrow'

	local left_component = ''
	if left_variant == 'arrow' then
		left_component = '▸'
	elseif left_variant == 'plus' then
		left_component = ''
	else
		left_component = left_variant
	end

	local right_component = ''
	if right_variant == 'minimal' then
		right_component = ''
	elseif right_variant == 'jetbrains' then
		right_component = '{  }'
	elseif right_variant == 'vscode' then
		right_component = '{ ∙∙∙ }'
	else
		right_component = right_variant
	end

	local main = table.concat({
		left_component,
		components.line,
		right_component,
	}, ' ')

	local buffer = get_expansion_string(#main, ' ')
	return main .. buffer
end
