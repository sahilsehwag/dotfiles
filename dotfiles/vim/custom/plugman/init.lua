--[[
HOOK:before_plugin_load
PACMAN START
	PLUGINS
PACMAN END
HOOK:after_plugin_load

IF NOT_INSTALLED
	HOOK:before_plugin_install
	PLUGIN
	HOOK:after_plugin_install
END

HOOK:before_config_load
CONFIG
HOOK:after_config_load
--]]

local merge = require('libs.utils').table.dict.merge

local loaders = require('plugman.loaders')
local load_config = require('plugman.load_config')

local defaults = {
	paths = {
		plugins = vim.fn.expand('~/.config/vim-plugins'),
		configs = 'configs',
	},
	config = {},
	loader = 'plug',
	plugins = {},
	groups = {},
	group = nil,
	scripts = {},
	logger = vim.notify,
}

local is_plugin_installed = function(config, plugin)
	return vim.fn.isdirectory(
		vim.fn.expand(config.paths.plugins .. '/' .. vim.fn.split(plugin, '/')[2])
	) == 1
end

local is_plugin_enabled = function(config, plugin)
	local plugin_config = config.config[plugin]
	return (
		plugin_config == nil or
		plugin_config.is_enabled == nil or
		plugin_config.is_enabled()
	)
end

function get_first_enabled_plugin(config, plugins)
	for _, plugin in ipairs(plugins) do
		if type(plugin) == 'string' then
			if is_plugin_enabled(config, plugin) then
				return plugin
			end
		elseif type(plugin) == 'table' then
      local plugin = get_first_enabled_plugin(config, plugin)
			if plugin then
				return plugin
			end
		else
			--LOG
		end
	end
end

local extract_plugin_hooks = function(config, hooks, plugin)
	local plugin_config = config.config[plugin]
	
	if plugin_config and plugin_config.hooks then
		for hook, _ in pairs(hooks) do
			if plugin_config.hooks[hook] then
				hooks[hook][plugin] = plugin_config.hooks[hook]
			end
		end
	end
end

local run_hook = function(config, hooks, hook)
	for plugin, fn in pairs(hooks[hook]) do
		fn(config)
	end
end

local load_configs = function(config, plugins, hooks)
	for _, plugin in ipairs(plugins) do
		if hooks.before_config_load[plugin] then
			hooks.before_config_load[plugin]()
		end
		
		load_config(config, plugin)
		
		if hooks.after_config_load[plugin] then
			hooks.after_config_load[plugin]()
		end
	end
end

local extract_dependencies = function(config, plugin, dependency_type, groups)
	if type(plugin) == 'string' then
		local plugin_config = config.config[plugin]
		
		if plugin_config and plugin_config.dependencies and plugin_config.dependencies[dependency_type] then
			for _, dependency in ipairs(plugin_config.dependencies[dependency_type]) do
				table.insert(groups.dependencies, dependency)
				group_plugin(config, dependency, groups)
			end
		end
	else
		--LOG
	end
end

function group_plugin(config, plugin, groups)
	local plugin = (
		(type(plugin) == 'string' and is_plugin_enabled(config, plugin) and plugin) or
		(type(plugin) == 'table' and get_first_enabled_plugin(config, plugin))
	)
	
	if vim.fn.index(groups.enabled, plugin) ~= -1 then
		return
	end
	
	if not plugin then
		--LOG
	elseif plugin == '' then
		--LOG
	else
		extract_dependencies(config, plugin, 'pre', groups)
		
		local group = (
			(is_plugin_installed(config, plugin) and groups.installed) or
			groups.not_installed
		)
		table.insert(groups.enabled, plugin)
		table.insert(group, plugin)
		extract_plugin_hooks(config, groups.hooks, plugin)
		
		extract_dependencies(config, plugin, 'post', groups)
	end
end

local group_plugins = function(config)
	local groups = {
		enabled = {},
		disabled = {},
		installed = {},
		not_installed = {},
		hooks = {
			before_plugin_load = {},
			after_plugin_load = {},
			before_config_load = {},
			after_config_load = {},
			before_plugin_install = {},
			after_plugin_install = {},
		},
		dependencies = {},
	}
	
	local plugins = (
		config.plugins or
		config.groups[config.group]
	)
	
	for _, plugin in ipairs(plugins) do
		group_plugin(config, plugin, groups)
	end
	
	return groups
end

return function(cfg)
	local config = merge({
		defaults,
		cfg or {},
	})
	local groups = group_plugins(config)
	
	local loader = loaders[config.loader]
	
	if not loader.is_installed(config) then
		loader.install_pacman(config)
	end
	
	run_hook(config, groups.hooks, 'before_plugin_load')
	loader.load(config, groups)
	run_hook(config, groups.hooks, 'after_plugin_load')
	
	if #groups.not_installed ~= 0 then
		--run_hook(config, groups.hooks, 'before_plugin_install')
		loader.install(config, groups)
		--run_hook(config, groups.hooks, 'after_plugin_install')
	end
	
	load_configs(config, groups.enabled, groups.hooks)
end
