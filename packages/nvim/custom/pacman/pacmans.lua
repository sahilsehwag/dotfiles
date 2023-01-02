return {
	pacmans = {
		brew = {
			cmd = 'brew',
			help = '-h',
			list = 'list',
			info = 'show',
			install = 'install',
			uninstall = 'uninstall',
			upgrade = '',
			downgrade = '',
			update = '',
		},
		apt = {},
		scoop = {},
		npm = {
			cmd = 'npm',
			help = '-h',
			list = 'list',
			info = 'info',
			install = 'install --save-dev',
			uninstall = '',
			upgrade = '',
			downgrade = '',
			update = '',
		},
		yarn = {
			cmd = 'yarn',
			help = '-h',
			list = 'list',
			info = 'info',
			install = 'add',
			uninstall = 'remove',
			upgrade = 'update',
			downgrade = '',
			update = 'upgrade',
		},
		pip = {
			cmd = function()
				if vim.fn.executable('pip3') == 1 then
					return 'pip3'
				elseif vim.fn.executable('pip') == 1 then
					return 'pip'
				else
					--LOG
				end
			end,
			help = '-h',
			list = 'list',
			info = 'show',
			install = 'install',
			uninstall = 'uninstall',
			upgrade = '',
			downgrade = '',
			update = '',
		},
		conda = {},
		cargo = {},
	},
	groups = {
		mac = { 'brew' },
		windows = { 'scoop' },
		ubuntu = { 'apt' },
		javascript = {
			'npm',
			'yarn',
		},
		python = {
			'pip',
			'conda',
		},
	},
	logger = vim.notify,
}
