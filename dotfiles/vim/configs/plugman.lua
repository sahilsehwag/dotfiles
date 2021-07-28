require('plugman')({
  config = require(vim.g.config.configs.plugins).plugins,
  plugins = require(vim.g.config.configs.plugins).modes[vim.g.config.plugins],
  paths = {
    configs = vim.g.config.paths.configs,
    plugins = vim.g.config.paths.plugins,
  },
})
