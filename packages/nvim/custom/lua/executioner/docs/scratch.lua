local config = {}

local fn = function(config)
end

local value = VALUE|TABLE|FUNCTION

local helpers = { roots, scaffolders }

local language = {
	filetypes = {},
	extensions = {},
  --is_file = fn,

	roots = {},
  --is_project = fn,

  operations = {
		repls = {},
		compilers = {},
		runners = {},
		formatters = {},
		linters = {},
		testers = {},
		debuggers = {},

		openers = {},
		scaffolders = {},
		builders = {},
		deployers = {},

		-- TODO:
		installers = {},

		-- TODO:
		random = {},
	},
}

local scope = FILE|PROJECT|BUFFERS(TAB|ALL)

local operations = {
  name = {
    label = '',
    description = '',
    value = fn,
	},
}
