local getGitRoot = function()
	return vim.fn.substitute(
		vim.fn.system('git rev-parse --show-toplevel'),
		'\n',
		'',
		'g'
		)
end

local getProjectRoot = function()
	return getGitRoot()
end

local LANGUAGES = {
	-- system
	-- 'c',
	-- 'cpp',
	-- 'rust',
	'go',

	-- functional
	-- 'haskell',
	-- 'lisp',
	-- 'elisp',
	-- 'fsharp',
	-- 'ocaml',

	-- ICL
	-- 'java',
	-- 'cs',
	-- 'scala',

	-- interpreted
	'javascript',
	'typescript',
	'python',
	'lua',
	'r',
	'ruby',
	-- 'perl',
	-- 'php',

	-- frontend
	-- 'html',
	-- 'css',
	-- 'scss',
	-- 'sass',
	-- 'less',

	-- shell
	'sh',
	-- 'fish',
	-- 'batch',

	-- databases
	-- 'sqlite',
	-- 'mysql',
	-- 'mongo',
	-- 'redis',

	-- random
	-- 'procesisng',

	-- markup
	-- 'markdown',
	-- 'latex',
}

local languages = {
	--language = {
	--  type = '',
	--  config = {
	--    paths = {
	--      tests = '',
	--      fixtures = '',
	--      mocks = '',
	--    },
	--    defaults = {
	--      runners = '',
	--    },
	--    setup = { '', '' }
	--  },
	--  patterns = {
	--    source = '',
	--    target = '',
	--    test = '',
	--    fixture = '',
	--  },
	--  extensions = {},
	--  filetypes = {},
	--  compilers = {},
	--  runners = {},
	--  repls = {},
	--  linters = {},
	--  formatters = {},
	--  testers = {},
	--  debuggers = {},
	--  installers = {},
	--  builders = {},
	--  servers = {},
	--  helpers = {
	--    getProjectRoot = function()
	--    end,
	--    getSourceFile = function()
	--    end,
	--    getCompiledFile = function()
	--    end,
	--    getTestFile = function()
	--    end,
	--    getFixtureFile = function()
	--    end,
	--  },
	--  config = function()
	--  end,
	--},
}

for _, language in ipairs(LANGUAGES) do
	languages[language] = require('executioner/languages' .. '/' .. language)
end

return {
	languages = languages,
	helpers = {
		getGitRoot = getGitRoot,
		getProjectRoot = getProjectRoot,
	},
}
