local PROJECTS = {
	'javascript',
	--'react',
	--'typescript',
	--'python',
	--'lua',
	--'vim',
	--'lua_vim',
	'git',
}

local projects = {
	--project = {
	--	helpers = {
	--		is_project = 'function',
	--		get_project_root = 'function',
	--	},
	--	extensions = {},
	--	filetypes = {},
	--	default = ''|function,
	--	operations = {
	--		run = {
	--			config = {
	--				default = ''|{}|function,
	--				runner = '',
	--				type = 'external|internal'
	--			},
	--			commands = {
	--				command = '',
	--				command = {
	--					cmd = '',
	--					args = {},
	--				},
	--				command = function,
	--			}
	--		},
	--	},
	--	scaffolds = {
	--		file = {},
	--		directory = {},
	--	},
	--},
}

for _, project in ipairs(PROJECTS) do
	projects[project] = require('projectinator/projects' .. '/' .. project)
end

return {
	projects = projects,
	helpers = { },
}
