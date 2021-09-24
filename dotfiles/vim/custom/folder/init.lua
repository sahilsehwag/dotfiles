local merge = require('libs.utils').table.dict.merge

local DEFAULTS = {
	folder = 'default',
	components = require('folder.components'),
	folders = require('folder.folders'),
	args = {},
}

local resolve_components = function(components)
	local cmps = {}
	for name, fn in pairs(components) do
		cmps[name] = fn()
	end
	return cmps
end

local get_fold = function(config)
	local config = merge({
		DEFAULTS,
		config,
	})

	local folders = config.folders
	local components = resolve_components(config.components)
	local folder = (config.folder and folders[config.folder]) and config.folder or 'default'

	return folders[folder](components, config.args)
end

return {
	helpers = require('folder.helpers'),
	get_fold = get_fold,
	setup = function(config)
		_G.folder_get_fold = function()
			return get_fold(config)
		end
		vim.cmd('set foldtext=v:lua.folder_get_fold()')
	end,
}
