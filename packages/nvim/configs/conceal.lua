local conceal = require('conceal')

-- should be run before .generate_conceals to use user Configuration
conceal.setup({
	--[[ ['language'] = {
		enabled = bool,
		['keyword'] = {
				enabled     = bool,
				conceal     = string,
				highlight   = string
		}
	} ]]
	['lua'] = {
    enabled = false,
		['local'] = {
			enabled = false -- to disable concealing for 'local'
		},
		['return'] = {
			conceal = 'R' -- to set the concealing to 'R'
		},
		['for'] = {
			highlight = 'keyword' -- to set the Highlight group to '@keyword'
		}
	},
	['go'] = {
		func = {
			conceal = 'f'
		},
	},
	-- need to add custom TS queries for typescript
	--['typescript'] = {
	--  enabled = true,
	--  const = {
	--    conceal = '𝝼',
	--  },
	--  ['return'] = {
	--    conceal = '𝗥',
	--  },
	--  ['function'] = {
	--    conceal = '𝝺',
	--  },
	--  L = {
	--    conceal = '𝝺',
	--  },
	--}
})

-- generate the scm queries
-- only need to be run when the Configuration changes
conceal.generate_conceals()
vim.api.nvim_create_user_command('ConcealToggle', function()
	require'conceal'.toggle_conceal()
end, {})

