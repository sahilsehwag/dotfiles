local javascript = require('executioner.languages.javascript')

return {
	config = {
		defaults = {
			formatters = 'prettier',
		},
	},
	extenisons = { 'html' },
	filetypes = { 'html' },
	formatters = {
		prettier = javascript.formatters.prettier,
	}
}
