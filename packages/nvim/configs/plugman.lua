require("plugman")({
	config = require("sahilsehwag.configs.plugins").plugins,
	plugins = require("sahilsehwag.configs.plugins").modes[vim.g.config.plugins],
	paths = {
		configs = vim.g.config.paths.configs,
		plugins = vim.g.config.paths.plugins,
	},
})
