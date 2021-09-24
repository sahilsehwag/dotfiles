local adapt = function(plugin, plugin_config)
	local options = { plugin }

	if plugin_config then
		if plugin_config.alias then
			options.as = plugin_config.alias
		end
		if plugin_config.branch then
			options.branch = plugin_config.branch
		end
		if plugin_config.tag then
			options.tag = plugin_config.tag
		end
		if plugin_config.commit then
			options.commit = plugin_config.commit
		end
		if plugin_config.rtp then
			options.rtp = plugin_config.rtp
		end
		if plugin_config.directory then
			options.dir = plugin_config.directory
		end
		if plugin_config.is_locked then
			options.frozen = plugin_config.is_locked() and true or false
		end
		if plugin_config.post_install then
			options.run = plugin_config.post_install
		end
		if plugin_config.lazyload then
			if plugin_config.lazyload.filetypes then
				options.ft = plugin_config.filetypes
			end
			if plugin_config.lazyload.cmds then
				options.cmd = plugin_config.cmds
			end
		end
	end

	return options
end

local run_hook = function(hooks, hook_type, plugins)
	for _, plugin in ipairs(plugins) do
		local fn = hooks[hook_type][plugin]
		if fn then fn() end
	end
end

return {
	is_installed = function(config)
		if vim.fn.IsNix() then
			return vim.fn.filereadable(vim.fn.expand('~/.local/share/nvim/site/pack/packer/start/packer.nvim')) == 1
		elseif vim.fn.IsWindows() then
			return vim.fn.filereadable(vim.fn.expand('$env:LOCALAPPDATA\\nvim-data\\site\\pack\\packer\\start\\packer.nvim')) == 1
		end
	end,
	install_pacman = function(config)
		if vim.fn.IsNix() then
			vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim')
		elseif vim.fn.IsWindows() then
			vim.fn.system('git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\\nvim-data\\site\\pack\\packer\\start\\packer.nvim"')
		end
	end,
	install = function(config, groups)
		run_hook(groups.hooks, 'before_plugin_install', groups.not_installed)
		vim.cmd('PackerSync')
		run_hook(groups.hooks, 'after_plugin_install', groups.not_installed)
	end,
	load = function(config, groups)
		print('hello')
		vim.cmd [[packadd packer.nvim]]

		require('packer').startup(function(use)
			for _, plugin in ipairs(groups.enabled) do
				local plugin_config = config.config[plugin]
				use(adapt(plugin, plugin_config))
			end
		end)

		vim.cmd('PackerSync')
	end,
}
