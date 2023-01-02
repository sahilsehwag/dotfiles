"to catch up with pacman.lua
function GetPluginInfo(pluginName)
	if exists('g:plugins') && has_key(g:plugins, a:pluginName)
		return g:plugins[a:pluginName]
	endif
endfunction

function LoadPlugins(Loader, plugins)
	for plugin in a:plugins
		call a:Loader(plugin)
	endfor
endfunction

function DefaultConfigResolver(pluginName)
	let pluginInfo = GetPluginInfo(a:pluginName)
	if !empty(pluginInfo) && get(pluginInfo, 'isEnabled', v:true) && has_key(pluginInfo, 'config')
		return pluginInfo.config
	endif
endfunction

function LoadConfigs(ConfigResolver, plugins)
	for plugin in a:plugins
		if type(plugin) == type('')
			let pluginInfo = GetPluginInfo(plugin)
			let configPath = a:ConfigResolver(plugin)
		elseif type(plugin) == type([]) && len(plugin) == 3
			let configPath = plugin[2]
		endif

		if type(configPath) == type('')
			let configPath = 'plugins/' . configPath
			if match(configPath, 'vim$') > -1
				execute 'runtime ' . configPath
			elseif match(configPath, 'lua$') > -1
				lua require(configPath)
			endif
		endif
	endfor
endfunction

function PlugLoader(plugin)
	if type(a:plugin) == type('')
		let pluginInfo = GetPluginInfo(a:plugin)
		if type(pluginInfo) == type({}) && get(pluginInfo, 'isEnabled', v:true)
			execute 'Plug ' . "'" . pluginInfo.url . "'"
		elseif match(a:plugin, '/') > -1
			execute 'Plug ' . "'" . a:plugin . "'"
		endif
	elseif type(a:plugin) == type([])
		if len(a:plugin) >= 2
			execute 'Plug ' . "'" . a:plugin[0] . "', " . string(a:plugin[1])
		elseif len(a:plugin) == 1
			execute 'Plug ' . "'" . a:plugin[0] . "'"
		end
	endif
endfunction

function LoadPluginsUsingPlug(plugins, ...)
	call plug#begin()
	call LoadPlugins(function('PlugLoader'), a:plugins)
	call plug#end()

	call LoadConfigs(function('DefaultConfigResolver'), a:plugins)

	if a:0 == 1
		for config in a:1
			execute 'runtime plugins/' . config
		endfor
	endif
endfunction

let g:loaders = {
	\'plug': function('LoadPluginsUsingPlug'),
\}
