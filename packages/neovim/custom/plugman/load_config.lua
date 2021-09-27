local is_config_present = function(config_path)
	return vim.fn.filereadable(vim.fn.globpath(vim.o.rtp, config_path))
end

local get_config_path = function(config_root, config_name)
	local config_path = config_root .. '/' .. config_name

	if is_config_present(config_path) == 1 then
		return config_path
	elseif is_config_present(config_path .. '.lua') == 1 then
		return config_path .. '.lua'
	elseif is_config_present(config_path .. '/init.lua') == 1 then
		return config_path .. '/init.lua'
	elseif is_config_present(config_path .. '.vim') == 1 then
		return config_path .. '.vim'
	elseif is_config_present(config_path .. '/init.vim') == 1 then
		return config_path .. '/init.vim'
	end
end

local get_config_name = function(config, plugin)
	local plugin_name = vim.fn.split(plugin, '/')[2]
	
	return (
		string.match(plugin_name, '%.') and
			vim.fn.split(plugin_name, '\\.')[1]	or
			plugin_name
	)
end

local load_config = function(config, config_name)
	local config_path = get_config_path(config.paths.configs, config_name)
	if config_path then
		vim.cmd('runtime' .. ' ' .. config_path)
	end
end

return function(config, plugin)
	local plugin_config = config.config[plugin]
	
	if plugin_config and plugin_config.should_load_config == false then
		return
	end
	
	if plugin_config and plugin_config.config then
		if type(plugin_config.config) == 'function' then
			plugin_config.config()
		elseif type(plugin_config.config) == 'string' then
			load_config(config, plugin_config.config)
		else
			--LOG
		end
	else
		load_config(config, get_config_name(config, plugin))
	end
end
