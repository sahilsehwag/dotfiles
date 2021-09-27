local utils = require('libs.utils')
local merge = utils.table.dict.merge

local get_pane_height = function(options)
	return (
		options.h and
			'-l ' .. options.h or
			''
	)
end

local get_pane_width = function(options)
	return (
		options.w and
			'-l ' .. options.w or
			''
	)
end

local get_popup_size = function(options)
	return vim.fn.join({
		options.w and ('-w' .. options.w) or '',
		options.h and ('-h' .. options.h) or '',
	})
end

local get_layout = function(options)
	local name = options.n and ( ' -n ' .. options.n) or ''

	if options.l == 'h' then
		return (
			_G.tmuxinator.config.inverted_splits and
			'split-pane -v ' .. get_pane_height(options) or
			'split-pane -h ' .. get_pane_width(options)
		)
	elseif options.l == 'v' then
		return (
			_G.tmuxinator.config.inverted_splits and
			'split-pane -h ' .. get_pane_width(options) or
			'split-pane -v ' .. get_pane_height(options)
		)
	elseif options.l == 'w' then
		return ('new-window' .. name)
	elseif options.l == 's' then
		local name = options.n and (' -s ' .. options.n) or ''
		return ('new-session -d' .. name)
	elseif options.l == 'p' then
		return ('popup ' .. get_popup_size(options))
	end
end

local get_shell_cmd = function(options)
	return vim.fn.join({
		'"',
		options.cmd,
		options.c == true and '' or ';read',
		'"',
	})
end

local get_cmd = function(config, cmd)
	local options = { cmd = cmd }

	for _, option in ipairs(vim.fn.split(config, '\\.')) do
		local type = string.sub(option, 1, 1)
		local value = string.sub(option, 2)

		if type == 'w' then
			options.w = value
		elseif type == 'h' then
			options.h = value
		elseif type == 'l' then
			options.l = value
		elseif type == 'n' then
			options.n = value
		elseif type == 'c' then
			options.c = value == 't'
		end
	end

	return vim.fn.join({
		'tmux',
		get_layout(options),
		get_shell_cmd(options),
	}, ' ')
end

return {
	setup = function(config)
		_G.tmuxinator = {
			config = merge({
				require('tmuxinator.config'),
				config or {},
			}),
		}

		vim.cmd [[ command! -nargs=+ T lua require("tmuxinator").run_cmd(<q-args>) ]]
		vim.cmd [[ command! -nargs=+ Tmuxinator lua require("tmuxinator").run_cmd(<q-args>) ]]
	end,
	get_cmd = get_cmd,
	run_cmd = function(args)
		local args = vim.fn.split(args, ' ')
		local config = args[1]
		local cmd = vim.fn.join({unpack(args, 2)}, ' ')

		vim.fn.system(get_cmd(config, cmd))
	end,
}
