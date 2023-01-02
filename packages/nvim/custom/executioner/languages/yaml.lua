local javascript = require('executioner.languages.javascript')

return {
	config = {
		defaults = {
			formatters = 'prettier',
		},
	},
	extenisons = { 'yaml' },
	filetypes = { 'yaml' },
	formatters = {
		prettier = javascript.formatters.prettier,
	}
}
