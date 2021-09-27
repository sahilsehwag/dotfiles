local javascript = require('executioner.languages.javascript')

return {
	config = {
		defaults = {
			formatters = 'prettier',
		},
	},
	extenisons = { 'scss' },
	filetypes = { 'scss' },
	formatters = {
		prettier = javascript.formatters.prettier,
	}
}
