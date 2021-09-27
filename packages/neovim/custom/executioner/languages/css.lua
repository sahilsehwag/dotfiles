local javascript = require('executioner.languages.javascript')

return {
	config = {
		defaults = {
			formatters = 'prettier',
		},
	},
	extenisons = { 'css' },
	filetypes = { 'css' },
	formatters = {
		prettier = javascript.formatters.prettier,
	}
}
