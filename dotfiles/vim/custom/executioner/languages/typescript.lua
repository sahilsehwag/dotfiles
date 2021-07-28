local merge = require('libs/utils').table.dict.merge
local javascript = require('executioner.languages.javascript')

local get_compiled_file = function(filename)
end

return {
	config = merge({javascript.config, {
		defaults = merge({javascript.config.defaults, {
			compilers = 'tsc',
			repls = 'tsnode',
		}})
	}}),
	patterns = {
		target = '%:p:r:S.js',
	},
	extenisons = {
		'ts',
		'tsx',
	},
	filetypes = {
		'typescript',
		'typescriptreact',
		'typescriptcommon',
	},
	installers = javascript.installers,
	compilers = {
		tsc = {
			cmd = function()
				return javascript.helpers.getExecutable('tsc')
			end,
		},
	},
	runners = javascript.runners,
	repls = {
		tsnode = 'ts-node',
	},
	formatters = javascript.formatters,
	linters = {
		eslint = javascript.linters.eslint,
		tslint = {
			cmd = function()
				return javascript.helpers.getExecutable('tslint')
			end,
		},
	},
	testers = javascript.testers,
	debuggers = javascript.debuggers,
	helpers = javascript.helpers,
}
