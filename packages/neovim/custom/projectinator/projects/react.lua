local js = require('projectinator.projects.javascript')

local get_project_name = function(label)
	return vim.fn.input(label or 'Enter Project name > ')
end

return {
	name =	'react',
	type = 'framework',
	helpers = {
		--TEMP
		is_project = function()
			return #(vim.fn.system('npm list react | grep react')) > 0
		end,
		get_project_root = js.helpers.get_project_root,
		get_component_root = function()
		end,
	},
	roots = js.roots,
	extensions = js.extensions,
	filetypes = js.filetypes,
	default = js.default,
	operations = {
		create = {
			config = {
				default = 'cra_webapp_javasript',
			},
			commands = {
				cra_webapp_javasript = function()
					return 'npx create-react-app ' .. get_project_name()
				end,
				--TODO
				cra_webapp_typescript = function()
					local project_name = vim.fn.input('Enter Project name > ')
					return 'npx create-react-app ' .. get_project_name()
				end,
				--TODO
				cra_extension_javascript = function()
					local project_name = vim.fn.input('Enter Project name > ')
					return 'npx create-react-app ' .. get_project_name() .. ' --scripts-version react-browser-extension-scripts --template browser-extension'
				end,
				cra_extension_typescript = function()
					local project_name = vim.fn.input('Enter Project name > ')
					return 'npx create-react-app ' .. get_project_name() .. ' --scripts-version react-browser-extension-scripts --template browser-extension'
				end,
			},
		},
		build = {
			config = {
				default = 'webpack',
			},
			commands = {
				webpack = '',
			},
		},
		run = {
			config = {
				default = 'webpack',
			},
			commands = {
				webpack = '',
			},
		},
	},
	scaffolds = {
		file = {
			component = function(name, subtype)
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
}
