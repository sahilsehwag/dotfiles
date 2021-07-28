
return {
	project = {
		config = {},
		helpers = {},
		initializers = {},
		scaffolders = {
			file = {},
			directory = {},
		},
		builders = {},
		runners = {},
	},

	-- general
	-- git = {}
	-- javascript = {}

	-- frontend
	-- vanilla = {},
	react = {
		config = {
			paths = {
				test = '../__tests__',
				fixture = '../__fixtures__',
				mock = '../__mocks__',
			},
			patterns = {
				test = 'filename.[test].extension',
				fixture = 'filename.[fixture].extension',
			},
		},
		helpers = {
			isReactProject = function()
			end,
			getProjectRoot = function()
			end,
			getComponentRoot = function()
			end,
		},
		initializers = {
			cra = {},
		},
		scaffolders = {
			file = {
				component = function(name, subtype)
					if subtype == 'class' then
					elseif subtype == 'function' then
					elseif subtype == 'error' then
					else
					end
				end,
				hook = function(name, subtype)
				end,
				style = function(name, subtype)
				end,
				test = function(name, subtype)
				end,
				fixture = function(name, subtype)
				end,
				mock = function(name, subtype)
				end,
				helper = function(name, subtype)
				end,
				constant = function(name, subtype)
				end,
			},
			directory = {
				component = function()
				end,
				test = function()
				end,
				mock = function()
				end,
				fixture = function()
				end
			},
		},
		builders = {
			webpack = {},
		},
		runners = {
			webpack = {}
		},
	},
	-- angular = {},

	-- backend
	-- django = {},
	-- flask = {},
	-- spring = {},

	-- vim/nvim
	-- vimscript = {},
	-- lua = {},
	-- python = {},
}
