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
	local paths = vim.split(vim.fn.glob('~/.config/nvim/plugins/lua/lib/funktional/' .. dir .. '/*.lua'), '\n')

	local modules = {}
	for _, path in ipairs(paths) do
		local name = path:match('([^/]+)%.lua$')
		if name then
			local module = 'lib/funktional/' .. dir .. '/' .. name
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

--pure
--core|types
--extensions|aliases|unsafe
--libs|algorithms
--helpers|utilities
--integrations
return load({
	{ 'pure',                       'table', 'pure' },
	{ 'pure/typeclasses',           'table', 'pure' },
	{ 'pure/typeclasses/algebraic', 'table', 'pure' },
	{ 'pure/types',                 'table', 'pure' },
	{ 'pure/types/core',            'table', 'pure' },

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

	{ 'utilities' },
	{ 'helpers'		},

	{ 'helpers/nvim', 'table', 'nvim' },
	{ 'helpers/vim',	'table', 'vim'	},

	{ 'types/abstract',		'table', 'types' },
	{ 'types/algebraic',	'table', 'types' },
	{ 'types/functional', 'table', 'types' },

	{ 'algorithms/searching', 'table', 'search' },
	{ 'algorithms/sorting',		'table', 'sort'		},

	{ 'libs/shell',			 'table', 'sh'	},
	{ 'libs/filesystem', 'table', 'fs'	},
	{ 'libs/logger',		 'table', 'log' },
	{ 'libs/network',		 'table', 'net' },
	{ 'libs/numpy',			 'table', 'np'	},
	{ 'libs/pandas',		 'table', 'pd'	},

	{ 'libs/shell/extensions',			'table', 'sh'  },
	{ 'libs/filesystem/extensions', 'table', 'fs'  },
	{ 'libs/logger/extensions',			'table', 'log' },
	{ 'libs/network/extensions',		'table', 'net' },
	{ 'libs/numpy/extensions',			'table', 'np'  },
	{ 'libs/pandas/extensions',			'table', 'pd'  },

	{ 'integrations/git',    'table', 'git'    },
	{ 'integrations/tmux',   'table', 'tmux'   },
	{ 'integrations/fzf',    'table', 'fzf'    },
	{ 'integrations/mprocs', 'table', 'mprocs' },

})
