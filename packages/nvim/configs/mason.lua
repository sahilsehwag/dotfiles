-- Uber's ~/.npmrc points to internal registry; public packages like ts-server aren't there
vim.env.NPM_CONFIG_REGISTRY = 'https://registry.npmjs.org'

require('mason').setup()
