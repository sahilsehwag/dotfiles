local yarn = require('npm_scripts.engines.yarn')
local npm = require('npm_scripts.engines.npm')

return {
	run_script = function(scope)
		if yarn.is_installed() then
			yarn.run_script(scope)
		else
			npm.run_script(scope)
		end
	end,
	switch_workspace = function()
		if yarn.is_installed() then
			yarn.switch_workspace()
		else
			vim.notify('Yarn is not installed')
		end
	end,
}
