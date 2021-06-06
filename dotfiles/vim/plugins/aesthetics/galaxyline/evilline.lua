local galaxyline = require('galaxyline')
local sections = galaxyline.section

galaxyline.short_line_list = {
  'NvimTree',
  'vista',
  'dbui'
}

local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#fabd2f',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef';
  red      = '#ec5f67';
}

local isBufferNotEmpty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local modeVsColor = {
  n      = colors.magenta,
  i      = colors.green,
  v      = colors.blue,
  [''] = colors.blue,
  V      = colors.blue,
  c      = colors.red,
  no     = colors.magenta,
  s      = colors.orange,
  S      = colors.orange,
  [''] = colors.orange,
  ic     = colors.yellow,
  R      = colors.violet,
  Rv     = colors.violet,
  cv     = colors.red,
  ce     = colors.red,
  r      = colors.cyan,
  rm     = colors.cyan,
  ['r?'] = colors.cyan,
  ['!']  = colors.red,
  t      = colors.red,
}

local modeVsLabel = {
  n      = 'N',
  no     = 'O',
  i      = 'I',
  ic     = 'I',
  v      = 'V',
  V      = 'V',
  [''] = 'V',
  c      = 'C',
  cv     = 'C',
  ce     = 'C',
  s      = 'S',
  S      = 'S',
  [''] = 'S',
  r      = 'R',
  R      = 'R',
  Rv     = 'R',
  rm     = 'R',
  ['r?'] = 'R',
  ['!']  = '!',
  t      = 'T',
}

sections.left[1] = {
  RainbowRed = {
    provider = function()
      return '█ '
    end,
    highlight = {
      colors.blue,
      colors.bg
    }
  },
}

sections.left[2] = {
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
}

--gls.left[3] = {
--  FileSize = {
--    provider = 'FileSize',
--    condition = isBufferNotEmpty,
--    highlight = {
--      colors.fg,
--      colors.bg
--    }
--  }
--}

sections.left[4] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = isBufferNotEmpty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      colors.bg,
    },
  },
}

sections.left[5] = {
  FileName = {
    provider = {'FileName'},
    condition = isBufferNotEmpty,
    highlight = {
      colors.green,
      colors.bg,
      'bold',
    }
  }
}

--gls.left[6] = {
--  LineInfo = {
--    provider = 'LineColumn',
--    separator = ' ',
--    separator_highlight = {
--      'NONE',
--      colors.bg
--    },
--    highlight = {
--      colors.fg,
--      colors.bg
--    },
--  },
--}

--gls.left[7] = {
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
--  }
--}

sections.left[8] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {
      colors.red,
      colors.bg
    },
  }
}

sections.left[9] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {
      colors.yellow,
      colors.bg
    },
  }
}

sections.left[10] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {
      colors.cyan,
      colors.bg
    },
  }
}

sections.left[11] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {
      colors.blue,
      colors.bg
    },
  }
}

sections.left[12] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '+',
    highlight = {
      colors.green,
      colors.bg
    },
  }
}

sections.left[13] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '~',
    highlight = {
      colors.orange,
      colors.bg
    },
  }
}

sections.left[14] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '-',
    highlight = {
      colors.red,
      colors.bg
    },
  }
}

sections.right[1] = {
  GetLspClient = {
    provider = 'GetLspClient',
    icon = '  ',
    highlight = {
      colors.magenta,
      colors.bg,
    },
    separator = ' ',
    separator_highlight = {
      'NONE',
      colors.bg
    },
  }
}

sections.right[2] = {
  FileEncode = {
    provider = 'FileEncode',
    separator = ' ',
    separator_highlight = {
      'NONE',
      colors.bg
    },
    highlight = {
      colors.cyan,
      colors.bg,
      'bold'
    },
  }
}

sections.right[3] = {
  FileFormat = {
    provider = 'FileFormat',
    separator = ' ',
    separator_highlight = {
      'NONE',
      colors.bg
    },
    highlight = {
      colors.cyan,
      colors.bg,
      'bold'
    },
  }
}

sections.right[4] = {
  GitIcon = {
    provider = function()
      return '  '
    end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    separator = ' ',
    separator_highlight = {
      'NONE',
      colors.bg
    },
    highlight = {
      colors.violet,
      colors.bg,
      'bold'
    },
  }
}

sections.right[5] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {
      colors.violet,
      colors.bg,
      'bold'
    },
  }
}

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

sections.right[8] = {
  RainbowBlue = {
    provider = function()
      return ' █'
    end,
    highlight = {
      colors.blue,
      colors.bg
    },
  },
}

sections.short_line_left[1] = {
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
  }
}

sections.short_line_left[2] = {
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
  }
}

sections.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {
      colors.fg,
      colors.bg,
    },
  }
}
