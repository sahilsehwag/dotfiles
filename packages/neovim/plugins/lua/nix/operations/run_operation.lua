local operations = {
	{
		name = 'sort-increasing',
		description = 'Sort increasing',
		get_cmd = function()
			return 'sort'
		end,
	},
	{
		name = 'sort-decreasing',
		description = 'Sort decreasing',
		get_cmd = function()
			return 'sort -r'
		end,
	},
	{
		name = 'remove-duplicates',
		description = 'Remove duplicates',
		get_cmd = function()
			--return 'sort -u'
			return 'sort | uniq'
		end,
	},
	{
		name = 'show-unique',
		description = 'Show unique',
		get_cmd = function()
			--return 'sort -u'
			return 'sort | uniq -u'
		end,
	},
	{
		name = 'remove-unique',
		description = 'Remove unique',
		get_cmd = function()
			return 'sort | uniq -d'
		end,
	},
	{
		name = 'count-unique',
		description = 'Count unique',
		get_cmd = function()
			return 'sort | uniq -uc'
		end,
	},
	{
		name = 'count-duplicates',
		description = 'Count duplicates',
		get_cmd = function()
			return 'sort | uniq -dc'
		end,
	},
	{
		name = 'count-all',
		description = 'Count all',
		get_cmd = function()
			return 'sort | uniq -c'
		end,
	},
	{
		name = 'count-all-sorted-by-frequency',
		description = 'Show counts sorted by frequency',
		get_cmd = function()
			return 'sort | uniq -c | sort -nr'
		end,
	},
	{
		name = 'format-yaml',
		description = 'Format yaml',
		get_cmd = function()
			return 'yq -P -o=yaml'
		end,
	},
	{
		name = 'format-json',
		description = 'Format json',
		get_cmd = function()
			if vim.fn.executable('yq') == 1 then
				return 'yq -P -o=json'
			else
				return 'jq'
			end
		end,
	},
	{
		name = 'json-to-yaml',
		description = 'Convert JSON to YAML',
		get_cmd = function()
			return 'yq -P -o=yaml'
		end,
	},
	{
		name = 'yaml-to-json',
		description = 'Convert YAML to JSON',
		get_cmd = function()
			return 'yq -P -o=json'
		end,
	},
	{
		name = 'query-json',
		description = 'Query JSON',
		get_cmd = function()
			local query = vim.fn.input('Query: ')
			if vim.fn.executable('yq') == 1 then
				return 'yq -r -P -o=json ' .. query
			else
				return 'jq -r ' .. query
			end
		end,
	},
	{
		name = 'query-yaml',
		description = 'Query YAML',
		get_cmd = function()
			local query = vim.fn.input('Query: ')
			return 'yq -o=yaml "' .. query .. '"'
		end,
	},
	{
		name = 'format-csv',
		description = 'Format csv',
		get_cmd = function()
			return ''
		end,
	},
	{
		name = 'run-shell-cmd',
		description = 'Run shell command',
		get_cmd = function()
			if vim.fn.executable('zsh') == 1 then
				return '/usr/bin/env zsh'
			elseif vim.fn.executable('bash') == 1 then
				return '/usr/bin/env bash'
			else
				return '/usr/bin/env sh'
			end
		end,
	},
	{
		name = 'find-in-directory',
		description = 'Find files/dirs in directory',
		get_cmd = function()
			if vim.fn.executable('fd') then
				return 'fd "" ' .. F.vim.get_selection()
			else
				return 'find'
			end
		end,
	},
	{
		name = 'find-files-in-directory',
		description = 'Find files in directory',
		get_cmd = function()
			if vim.fn.executable('fd') then
				return 'fd -tf "" ' .. F.vim.get_selection()
			else
				return 'find'
			end
		end,
	},
	{
		name = 'find-dirs-in-directory',
		description = 'Find dirs in directory',
		get_cmd = function()
			if vim.fn.executable('fd') then
				return 'fd -td "" ' .. F.vim.get_selection()
			else
				return 'find'
			end
		end,
	},
	{
		name = 'find-pattern-in-pwd',
		description = 'Find files/dirs matching pattern in pwd',
		get_cmd = function()
			if vim.fn.executable('fd') then
				return 'fd "' .. F.vim.get_selection() .. '" ' .. vim.fn.getcwd()
			else
				return 'find'
			end
		end,
	},
}

return function()
	vim.ui.select(operations, {
		prompt = 'Run operation',
		format_item = F.get('name'),
	}, function(operation)
		if operation then
			vim.api.nvim_command("'<,'>!" .. operation.get_cmd())
		end
	end)
end
