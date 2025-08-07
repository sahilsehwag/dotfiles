local javascript = require('executioner.languages.javascript')

return {
	config = {
		defaults = {
			formatters = 'prettier',
		},
	},
	extenisons = { 'json' },
	filetypes = { 'json' },
	formatters = {
		prettier = javascript.formatters.prettier,
	}
}
