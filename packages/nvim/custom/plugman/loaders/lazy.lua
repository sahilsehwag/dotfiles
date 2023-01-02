local adapt = function(plugin, plugin_config)
	local options = { plugin }

	if plugin_config then
		if plugin_config.branch then
			options.branch = plugin_config.branch
		end
		if plugin_config.url then
			if string.match(plugin_config.url, "^https?://") then
				options.url = plugin_config.url
			end
		end
		if plugin_config.tag then
			options.tag = plugin_config.tag
		end
		if plugin_config.commit then
			options.commit = plugin_config.commit
		end
		if plugin_config.directory then
			options.dir = plugin_config.directory
		end
		if plugin_config.is_locked then
			options.pin = plugin_config.is_locked() and true or false
		end
		if plugin_config.post_install then
			options.build = plugin_config.post_install
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
		if fn then
			fn()
		end
	end
end

return {
	is_installed = function(config)
		local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
		return vim.loop.fs_stat(lazypath)
	end,
	install_pacman = function(config)
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end,
	install = function(config, groups)
		run_hook(groups.hooks, "before_plugin_install", groups.not_installed)
		vim.cmd("Lazy install")
		run_hook(groups.hooks, "after_plugin_install", groups.not_installed)
	end,
	load = function(config, groups)
		local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
		vim.opt.rtp:prepend(lazypath)

		local plugins = {}

		for i, plugin in ipairs(groups.enabled) do
			local plugin_config = config.config[plugin]
			plugins[i] = adapt(plugin, plugin_config)
		end

		--local file = io.open("/Users/sahilsehwag/dotfiles/packages/nvim/lua/sahilsehwag/lazy/plugins.lua", "w")
		--file:write('return' .. vim.inspect(plugins))
		--file:close()

		require("lazy").setup(plugins, {
			ui = { border = "single" },
		})
	end,
}
