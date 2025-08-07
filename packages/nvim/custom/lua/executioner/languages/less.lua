local javascript = require('executioner.languages.javascript')

return {
	config = {
		defaults = {
			formatters = 'prettier',
		},
	},
	extenisons = { 'less' },
	filetypes = { 'less' },
	formatters = {
		prettier = javascript.formatters.prettier,
	}
}
