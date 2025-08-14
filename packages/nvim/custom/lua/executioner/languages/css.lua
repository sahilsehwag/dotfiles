local javascript = require('executioner.languages.javascript')

return {
	config = {
		defaults = {
			formatters = 'prettier',
		},
	},
	extenisons = { 'css', 'scss', 'sass' },
	filetypes = { 'css', 'scss', 'sass' },
	formatters = {
		prettier = javascript.formatters.prettier,
	}
}
