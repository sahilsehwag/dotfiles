local utils = require('libs.utils')
local merge = utils.table.dict.merge

local CONFIG = require('pacman.config')

local get_args = function(args)
	if type(args) == 'function' then
		args = args()
	end

	return (
		(type(args) == 'table' and vim.fn.join(args, ' ')) or
		args or
		''
	)
end

local get_cmd = function(operation)
	if type(operation) == 'string' then
		return operation
	elseif type(operation) == 'function' then
		return operation()
	elseif type(operation) == 'table' then
		return operation.cmd
	else
		return ''
	end
end

local get_pacman_from_filetype = function(filetype)
	return CONFIG.groups[filetype][1]
end

return {
	setup = function(config)
		CONFIG = merge({ CONFIG, config or {} })
		vim.g.pacman = { config = CONFIG }
	end,
	pacman = function(config)
		local pacman = CONFIG.pacmans[
			config.pacman or
			get_pacman_from_filetype(config.filetype or vim.bo.filetype)
		]
		local operation = pacman[config.operation]

		local cmd = vim.fn.join({
			config.vim_cmd				or CONFIG.cmds.terminal,
			config.cmd						or get_cmd(pacman.cmd) .. ' ' .. get_cmd(operation),
			get_args(config.args or operation.args),
			config.package				or '',
		}, ' ')

		vim.cmd(cmd)
	end,
	get_system_pacman = function()
		if has('mac') == 1 or has('macunix') == 1 then
			if vim.fn.executable('scoop') then
				return 'brew'
			end
		elseif vim.fn.IsWindows() == 1 then
			if vim.fn.executable('scoop') then
				return 'scoop'
			end
		end
	end,
	get_project_pacman = function()
	end,
}
