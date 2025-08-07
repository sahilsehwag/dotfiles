return {
	name = 'javascript',
	type = 'language',
	helpers = {
		is_project = function(roots)
			local directory = vim.fn.expand('%:p:h') .. ';'
			for _, root in ipairs(roots or {}) do
				local path = (
					string.match(root, '/$') and
						vim.fn.finddir(root, directory) or
						vim.fn.findfile(root, directory)
				)
				if #(path) > 0 then
					return true
				end
			end
			return false
		end,
		get_project_root = function(roots)
			local directory = vim.fn.expand('%:p:h') .. ';'

			for _, root in ipairs(roots or {}) do
				local is_directory = string.match(root, '/$')
				local path = (
					is_directory and
						vim.fn.finddir(root, directory) or
						vim.fn.findfile(root, directory)
				)
				if #(path) > 0 then
					return vim.fn.fnamemodify(path, is_directory and ':p:h:h' or ':p:h')
				end
			end
		end,
	},
	roots = {
		'node_modules/',
		'package.json',
		'lerna.json',
		'jsconfig.json',
		'tsconfig.json',
	},
	extensions = {
		'js',
		'jsx',
		'ts',
		'tsx',
		'json',
	},
	filetypes = {
		'javascript',
		'javascriptreact',
		'typescript',
		'typescriptreact',
		'json',
	},
	default = function()
		if vim.fn.executable('yarn') then
			return 'yarn'
		else
			return 'npm'
		end
	end,
	operations = {
		--create = {
		--  commands = {
		--  },
		--},
		init = {
			commands = {
				npm = 'npm init',
				yarn = 'yarn init',
				lerna = 'npx lerna init',
			},
		},
		install = {
			commands = {
				npm = 'npm install',
				yarn = 'yarn',
				lerna = 'lerna bootstrap',
			},
		},
		lint = {
			commands = {
				npm = 'npm run lint',
				yarn = 'yarn run lint',
			},
		},
		format = {
			commands = {
				npm = 'npm run format',
				yarn = 'yarn run format',
			},
		},
		test = {
			commands = {
				npm = 'npm run test',
				yarn = 'yarn run test',
			},
		},
		run = {
			commands = {
				npm = 'npm run start',
				yarn = 'yarn run start',
			},
		},
		build = {
			commands = {
				npm = 'npm run build',
				yarn = 'yarn run build',
			},
		},
		release = {
			commands = {
				npm = 'npm run release',
				yarn = 'yarn run release',
			},
		},
		publish = {
			commands = {
				npm = 'npm run publish',
				yarn = 'yarn run publish',
				lerna = 'npx lerna publish',
			},
		},
		deploy = {
			commands = {
				npm = 'npm run deploy',
				yarn = 'yarn run deploy',
			},
		},
	},
	scaffolds = {
		file = { },
		directory = { },
	},
}
