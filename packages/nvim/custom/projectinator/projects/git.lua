return {
  name =  'git',
  type = 'vcs',
	helpers = {
		is_project = function()
			local directory = vim.fn.expand('%:p:h') .. ';'
			return #(vim.fn.finddir('.git', directory)) > 0
		end,
		get_project_root = function()
			return vim.fn.substitute(
				vim.fn.system('git rev-parse --show-toplevel'),
				'\n', '',
				'g'
				)
		end,
	},
	default = 'git',
	operations = {
		init = {
			commands = { git = 'git init' },
		},
	},
	scaffolds = {},
}
