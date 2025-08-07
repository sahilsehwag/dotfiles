local javascript = require("executioner.languages.javascript")

return {
	config = {
		defaults = {
			formatters = "prettier",
		},
	},
	extenisons = {
		"graphql",
		"gql",
	},
	filetypes = {
		"graphql",
	},
	formatters = {
		prettier = javascript.formatters.prettier,
	},
}
