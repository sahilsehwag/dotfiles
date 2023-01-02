local utils = require('libs.utils')
local merge = utils.table.dict.merge
local get_path = utils.table.dict.get_path
local is_list = utils.table.is_list

local renderers = require('executioner.renderers')
local integrations = require('executioner.integrations')

local get_user_config = function()
	return _G.executioner.config
end

local get_default_config = function()
	return _G.executioner.default_config
end

local get_config = function(config_type)
	return (
		config_type == 'default' and
			get_default_config() or
			get_user_config()
	)
end

local get_projects = function(config_type)
	return get_config(config_type).projects
end

local PROJECT_SELECTORS = {
	ALL = function(projects)
		return projects
	end,
	FIRST = function(projects)
		return projects[1]
	end,
	LAST = function(projects)
		return projects[#projects]
	end,
}

local get_project_cfg_from_name = function(project_name, config_type)
	return get_projects(config_type)[project_name]
end

local get_operation_from_name = function(project_name, op_name, config_type)
	return get_projects(config_type)[project_name].operations[op_name]
end

local get_project_cfgs_for_filetype = function(filetype, selector)
	local projects = {}
	for _, project in pairs(get_projects()) do
		for _, ft in ipairs(project.filetypes or {}) do
			if filetype == ft then
				table.insert(projects, project)
			end
		end
	end
	return selector(projects)
end

local get_project_cfgs_for_extension = function(extension, selector)
	local projects = {}
	for _, project in pairs(get_projects()) do
		for _, ext in ipairs(project.extensions or {}) do
			if extension == ext then
				table.insert(projects, project)
			end
		end
	end
	return selector(projects)
end

local get_project_cfgs_from_roots = function(selector)
	local projects = {}

	for _, project in pairs(get_projects()) do
		if project.helpers.is_project(project.roots) then
			table.insert(projects, project)
		end
	end

	return selector(projects)
end

local get_project_configs = function(op_config, selector)
	local projects = get_projects()

	local project_configs = (
		projects[get_path(op_config, 'project')] or
		--projects[op_config.filetype] or
		--projects[op_config.extension] or
		--get_project_cfg_from_filetype(op_config.filetype) or
		--get_project_cfg_from_extension(op_config.extension) or
		get_project_cfgs_from_roots(selector) or
		--TEMP
		projects[vim.fn.input('[executioner:init]Enter project > ')]
	)

	if project_configs then
		return project_configs
	else
		vim.notify('Project config for filetype "' .. op_config.filetype .. '" or with extension".' .. op_config.extension .. '" not found', 'debug')
	end
end

local get_operation_default = function(project, operation, op_config)
	local op_default = (
		get_path(op_config, 'default') or
		get_path(operation, 'config.default') or
		project.default
	)

	if type(op_default) == 'function' then
		op_default = op_default(project)
	end

	if is_list(op_default) then
		for _, default in ipairs(op_default) do
			if operation.commands[default] then
				return default
			end
		end
	end

	return op_default
end

local get_operation_cmd = function(project, operation, op_config)
	return operation.commands[get_operation_default(project, operation, op_config)]
end

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

local get_cmd = function(op_cmd, op_config)
	local cmd = (
		(type(op_cmd) == 'string') and op_cmd or
		(type(op_cmd) == 'function') and op_cmd() or
		(type(op_cmd.cmd) == 'function' and op_cmd.cmd()) or
		(type(op_cmd.cmd) == 'string' and op_cmd.cmd) or
		''
	)
	local args = get_args(op_config.args or op_cmd.args)

	return cmd .. ' ' .. args
end

local run_cmd = function(runner, cmd)
	if type(runner) == 'string' then
		vim.cmd(runner .. ' '.. cmd)
	elseif type(runner) == 'function' then
		runner(cmd)
	else
		--TODO
		vim.notify('Invalid type for runner')
	end
end

local create_operation_config = function(op_config)
	return merge({
		{
			filetype = vim.bo.filetype,
			extension = vim.fn.expand('%:e'),
		},
		op_config,
	})
end

local run_operation = function(op_name, op_config)
	local op_config = create_operation_config(op_config)

	local project = get_project_configs(op_config, PROJECT_SELECTORS.FIRST)
	local operation = project.operations[op_name]

	run_cmd(
		(
			op_config.runner or
			get_config().cmds[get_path(operation, 'config.type') or 'external'] or
			operation.config.runner
		),
		get_cmd(
			get_operation_cmd(project, operation, op_config),
			op_config
		)
	)
end

local list_operations = function(list_config)
	local projects = get_project_configs(nil, PROJECT_SELECTORS.ALL)
	for _, project in pairs(projects) do
		for op_name, operation in pairs(project.operations) do
			local op = table.concat({ project.name, op_name }, '.')
			local op_cmd = (
				'[' ..
				get_operation_default(project, operation) ..
				' "' .. get_operation_cmd(project, operation) .. '"' ..
				']'
			)

			--TODO
			print(op .. ' ' .. op_cmd)
		end
	end
end

return {
	setup = function(config)
		local default_config = require('executioner.config')

		_G.executioner = {
			default_config = default_config,
			config = merge({
				default_config,
				config or {}
			}),
			debug = false,
		}
	end,
	helpers = {
	},
	run_operation = run_operation,
	list_operations = list_operations,
}
