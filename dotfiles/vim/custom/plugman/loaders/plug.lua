local adapt = function(plugin_config)
	if plugin_config.plug then
		return plugin_config.plug
	else
		local options = {}
		
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
			options['do'] = plugin_config.post_install
		end
		if plugin_config.lazyload then
			if plugin_config.lazyload.filetypes then
				options['for'] = plugin_config.filetypes
			end
			if plugin_config.lazyload.cmds then
				options['on'] = plugin_config.cmds
			end
		end
		
		--HACK/TEMP
		vim.api.nvim_set_var('plugman_plug_options', options)
		return vim.fn.len(options) == 0 and '' or 'g:plugman_plug_options'
	end
end

local plug = function(plugin, options)
	if options then
		vim.cmd('Plug ' .. "'" .. plugin .. "', " .. options)
	else
		vim.cmd('Plug ' .. "'" .. plugin .. "'")
	end
end

return {
	is_installed = function(config)
		local data_dir = vim.fn.has('nvim') == 1 and vim.fn.stdpath('data') .. '/site' or '~/.vim'
		return vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) == 0
	end,
	install_pacman = function(config)
		if vim.fn.has('nvim') == 1 then
			if vim.fn.IsNix() then
				vim.fn.system('curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
			elseif vim.fn.IsWindows() then
				vim.fn.system('iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |` ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force')
			end
		else
			if vim.fn.IsNix() then
				vim.fn.system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
			elseif vim.fn.IsWindows() then
				vim.fn.system('iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |` ni $HOME/vimfiles/autoload/plug.vim -Force')
			end
		end
	end,
	install = function(config, groups)
		local plugins = {}
		for _, plugin in ipairs(groups.not_installed) do
			table.insert(plugins, vim.fn.split(plugin, '/')[2])
		end
		
		vim.cmd('PlugInstall ' .. table.concat(plugins, ' '))
	end,
	load = function(config, groups)
		vim.fn['plug#begin'](config.paths.plugins)
		
		for _, plugin in ipairs(groups.enabled) do
			local plugin_config = config.config[plugin]
			plug(
				plugin,
				plugin_config and adapt(plugin_config)
			)
		end
		
		vim.fn['plug#end']()
	end,
}
