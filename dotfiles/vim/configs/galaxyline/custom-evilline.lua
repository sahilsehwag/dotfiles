local galaxyline = require('galaxyline')
local sections = galaxyline.section

local components = require('statusline-components').components

local package = require('package-info')
local gps = require'nvim-gps'
--local lsp_status = require('lsp-status')

local colors = {
	bg			 = '#202328',
	fg			 = '#bbc2cf',
	yellow	 = '#fabd2f',
	cyan		 = '#008080',
	darkblue = '#081633',
	green		 = '#98be65',
	orange	 = '#FF8800',
	violet	 = '#a9a1e1',
	magenta  = '#c678dd',
	blue		 = '#51afef';
	red			 = '#ec5f67';
}

local isBufferNotEmpty = function()
	if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
		return true
	end
	return false
end

local checkwidth = function()
	local squeeze_width  = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end

local modeVsColor = {
	n			 = colors.magenta,
	i			 = colors.green,
	v			 = colors.blue,
	[''] = colors.blue,
	V			 = colors.blue,
	c			 = colors.red,
	no		 = colors.magenta,
	s			 = colors.orange,
	S			 = colors.orange,
	[''] = colors.orange,
	ic		 = colors.yellow,
	R			 = colors.violet,
	Rv		 = colors.violet,
	cv		 = colors.red,
	ce		 = colors.red,
	r			 = colors.cyan,
	rm		 = colors.cyan,
	['r?'] = colors.cyan,
	['!']  = colors.red,
	t			 = colors.red,
}

local modeVsLabel = {
	n			 = 'N',
	no		 = 'O',
	i			 = 'I',
	ic		 = 'I',
	v			 = 'V',
	V			 = 'V',
	[''] = 'V',
	c			 = 'C',
	cv		 = 'C',
	ce		 = 'C',
	s			 = 'S',
	S			 = 'S',
	[''] = 'S',
	r			 = 'R',
	R			 = 'R',
	Rv		 = 'R',
	rm		 = 'R',
	['r?'] = 'R',
	['!']  = '!',
	t			 = 'T',
}

galaxyline.short_line_list = {
	'defx',
	'packager',
	'LuaTree',
	'vista',
	'dbui',
	'startify',
	'term',
	'nerdtree',
	'fugitive',
	'fugitiveblame',
	'plug',
	'NvimTree',
	'dbui',
}

sections.left = {
	{
		RainbowRed = {
			provider = function()
				return '█ '
			end,
			highlight = {
				colors.blue,
				colors.bg
			},
		},
	},
	{
		ViMode = {
			provider = function()
				vim.api.nvim_command('hi GalaxyViMode guifg=' .. modeVsColor[vim.fn.mode()])
				return ' ' .. modeVsLabel[vim.fn.mode()] .. ' '
			end,
			highlight = {
				colors.red,
				colors.bg,
				'bold'
			},
		},
	},
	{
		FileIcon = {
			provider = 'FileIcon',
			condition = isBufferNotEmpty,
			highlight = {
				require('galaxyline.provider_fileinfo').get_file_icon_color,
				colors.bg,
			},
		},
	},
	{
		FileName = {
			provider = {'FileName'},
			condition = isBufferNotEmpty,
			highlight = {
				colors.green,
				colors.bg,
				'bold',
			},
		},
	},
	--{
	--  FileSize = {
	--    provider = 'FileSize',
	--    condition = isBufferNotEmpty,
	--    highlight = {
	--      colors.blue,
	--      colors.bg,
	--      'bold',
	--    },
	--  },
	--},
	--{
	--  LineInfo = {
	--    provider = 'LineColumn',
	--    separator = '',
	--    separator_highlight = {
	--      'NONE',
	--      colors.bg
	--    },
	--    highlight = {
	--      colors.fg,
	--      colors.bg
	--    },
	--  },
	--},
	--{
	--  PerCent = {
	--    provider = 'LinePercent',
	--    separator = ' ',
	--    separator_highlight = {
	--      'NONE',
	--      colors.bg
	--    },
	--    highlight = {
	--      colors.fg,
	--      colors.bg,
	--      'bold'
	--    },
	--  },
	--},
	{
		nvimGPS = {
			provider = function()
				return gps.get_location()
			end,
			condition = function()
				return gps.is_available()
			end,
			highlight = {
				colors.fg,
				colors.bg,
			}
		},
	},
	{
		Spacer = {
			provider = function()
				return ' '
			end,
			highlight = {
				colors.fg,
				colors.bg,
			}
		},
	},
	{
		PackageInfoStatus = {
			provider = function()
				return package.get_status()
			end,
			highlight = {
				colors.fg,
				colors.bg,
			}
		},
	},
}

sections.mid = {
}

sections.right = {
	{
		GetLspClient = {
			provider = components.lsp.servers,
			-- icon = '  ',
			icon = ' ',
			highlight = {
				colors.magenta,
				colors.bg,
			},
			separator = ' ',
			separator_highlight = {
				'NONE',
				colors.bg
			},
		},
	},
	--{
	--  LspStatus = {
	--    provider = lsp_status.status,
	--    --icon = ' ',
	--    highlight = {
	--      colors.magenta,
	--      colors.bg,
	--    },
	--  },
	--},
	{
		Spacer = {
			provider = function()
				return ' '
			end,
			highlight = {
				colors.fg,
				colors.bg,
			}
		},
	},
	{
		DiagnosticError = {
			provider = 'DiagnosticError',
			icon = '  ',
			highlight = {
				colors.red,
				colors.bg
			},
		},
	},
	{
		DiagnosticWarn = {
			provider = 'DiagnosticWarn',
			icon = '  ',
			-- icon = '  ',
			highlight = {
				colors.yellow,
				colors.bg
			},
		},
	},
	{
		DiagnosticHint = {
			provider = 'DiagnosticHint',
			-- icon = '  ',
			icon = '  ',
			highlight = {
				colors.cyan,
				colors.bg
			},
		},
	},
	{
		DiagnosticInfo = {
			provider = 'DiagnosticInfo',
			icon = '  ',
			highlight = {
				colors.blue,
				colors.bg
			},
		},
	},
	{
		DiffAdd = {
			provider = 'DiffAdd',
			condition = checkwidth,
			icon = '  ',
			highlight = {
				colors.green,
				colors.bg
			},
		},
	},
	{
		DiffModified = {
			provider = 'DiffModified',
			condition = checkwidth,
			icon = '  ',
			highlight = {
				colors.orange,
				colors.bg
			},
		},
	},
	{
		DiffRemove = {
			provider = 'DiffRemove',
			condition = checkwidth,
			icon = '  ',
			highlight = {
				colors.red,
				colors.bg
			},
		},
	},
	{
		GitIcon = {
			provider = function()
				return '  '
			end,
			condition = require('galaxyline.provider_vcs').check_git_workspace,
			separator_highlight = {
				'NONE',
				colors.bg
			},
			highlight = {
				colors.violet,
				colors.bg,
				'bold'
			},
		},
	},
	{
		GitBranch = {
			provider = 'GitBranch',
			condition = require('galaxyline.provider_vcs').check_git_workspace,
			highlight = {
				colors.violet,
				colors.bg,
				'bold',
			},
		},
	},
	{
		FileEncode = {
			provider = 'FileEncode',
			separator = ' ',
			highlight = {
				colors.cyan,
				colors.bg,
				'bold'
			},
		},
	},
	{
		FileFormat = {
			provider = 'FileFormat',
			separator = ' ',
			highlight = {
				colors.cyan,
				colors.bg,
				'bold'
			},
		},
	},
	--{
	--  PluginsMode = {
	--    provider = function()
	--      if type(vim.g.config.plugins) == 'string' then
	--        return '  [' .. vim.g.config.plugins .. ']'
	--      else
	--        return ''
	--      end
	--    end,
	--    highlight = {
	--      colors.magenta,
	--      colors.bg,
	--    },
	--  },
	--},
	{
		RainbowBlue = {
			provider = function()
				return '  █'
			end,
			highlight = {
				colors.blue,
				colors.bg,
			},
		},
	},
}

sections.short_line_left = {
	{
		BufferType = {
			provider = 'FileTypeName',
			separator = ' ',
			separator_highlight = {
				'NONE',
				colors.bg
			},
			highlight = {
				colors.blue,
				colors.bg,
				'bold'
			},
		},
	},
	{
		SFileName = {
			provider = function ()
				local fileinfo = require('galaxyline.provider_fileinfo')
				local fname = fileinfo.get_current_file_name()
				for _, v in ipairs(galaxyline.short_line_list) do
					if v == vim.bo.filetype then
						return ''
					end
				end
				return fname
			end,
			condition = isBufferNotEmpty,
			highlight = {
				colors.white,
				colors.bg,
				'bold',
			},
		},
	},
}

sections.short_line_right = {
	BufferIcon = {
		provider= 'BufferIcon',
		highlight = {
			colors.fg,
			colors.bg,
		},
	}
}

