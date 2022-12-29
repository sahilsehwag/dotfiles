--read ! fd -tf --exclude 'init.lua' --glob '*.lua'

NAMESPACE = 'F'
_G['Funk']		= {}
_G[NAMESPACE] = {}

local F = _G[NAMESPACE]

local get_module_name = function(module)
	local name = nil
	for v in string.gmatch(module, '([^%.]+)') do
		name = v
	end
	return name
end

local function lazy(module, name, type, parent)
	name = name or get_module_name(module)
	type = type or 'function'

		local mod = function(...)
			return require(module)(...)
		end

	if type == 'table' then
		F[parent] = F[parent] or {}
		Funk[parent] = Funk[parent] or {}

		F[parent][name] = mod
		Funk[parent][name] = mod
	else
		F[name] = mod
		Funk[name] = mod
	end

	return mod
end

local function load_modules(dir, type, parent)
	-- TODO:
	local paths = vim.split(vim.fn.glob('~/.config/nvim/plugins/lua/lib/funk/' .. dir .. '/*.lua'), '\n')

	local modules = {}
	for _, path in ipairs(paths) do
		local name = path:match('([^/]+)%.lua$')
		if name then
			local module = 'lib/funk/' .. dir .. '/' .. name
			modules[name] = lazy(module, name, type, parent)
		end
	end
	return modules
end

local function load(paths)
	local modules = {}
	for _, path in ipairs(paths) do
		local sub_modules = load_modules(unpack(path))
		for name, mod in pairs(sub_modules) do
			modules[name] = mod
		end
	end
	return modules
end

--core|types
--extensions|aliases|unsafe
--libs|algorithms
--helpers|utilities
--integrations
return load({
	{ 'core/general'	},
	{ 'core/oops'			},
	{ 'core/function' },
	{ 'core/type'			},
	{ 'core/logic'		},
	{ 'core/math'			},
	{ 'core/sequence' },
	{ 'core/table'		},
	{ 'core/list'			},
	{ 'core/dict'			},
	{ 'core/string'		},

	{ 'core/general/extensions'  },
	{ 'core/oops/extensions'     },
	{ 'core/function/extensions' },
	{ 'core/type/extensions'     },
	{ 'core/logic/extensions'    },
	{ 'core/math/extensions'     },
	{ 'core/sequence/extensions' },
	{ 'core/table/extensions'    },
	{ 'core/list/extensions'     },
	{ 'core/dict/extensions'     },
	{ 'core/string/extensions'   },

	{ 'core/general/aliases'  },
	{ 'core/oops/aliases'     },
	{ 'core/function/aliases' },
	{ 'core/type/aliases'     },
	{ 'core/logic/aliases'    },
	{ 'core/math/aliases'     },
	{ 'core/sequence/aliases' },
	{ 'core/table/aliases'    },
	{ 'core/list/aliases'     },
	{ 'core/dict/aliases'     },
	{ 'core/string/aliases'   },

	{ 'libs/shell',      'table', 'sh'  },
	{ 'libs/filesystem', 'table', 'fs'  },
	{ 'libs/os',         'table', 'os'  },
	{ 'libs/logger',     'table', 'log' },
	{ 'libs/network',    'table', 'net' },
	{ 'libs/numpy',      'table', 'np'  },
	{ 'libs/pandas',     'table', 'pd'  },

	{ 'libs/collections', 'table', 'types' },
	{ 'libs/algorithms',  'table', 'algos' },

	{ 'libs/shell/extensions',			'table', 'sh'  },
	{ 'libs/filesystem/extensions', 'table', 'fs'  },
	{ 'libs/logger/extensions',			'table', 'log' },
	{ 'libs/network/extensions',		'table', 'net' },
	{ 'libs/numpy/extensions',			'table', 'np'  },
	{ 'libs/pandas/extensions',			'table', 'pd'  },

	{ 'helpers/vim',    'table', 'vim'    },
	{ 'helpers/git',    'table', 'git'    },
	{ 'helpers/tmux',   'table', 'tmux'   },
	{ 'helpers/fzf',    'table', 'fzf'    },
	{ 'helpers/mprocs', 'table', 'mprocs' },
})
