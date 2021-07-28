local gl = require('galaxyline')
local gls = gl.section
local fileinfo = require('galaxyline.provider_fileinfo')

gl.short_line_list = {'NvimTree','vista','dbui','packer', 'startify'}

function hex_to_rgb(hex)
  local hex_in_decimal = tonumber(string.sub(hex, 2), 16);
  local mask = 255;
  return {
    r = bit.band(bit.rshift(hex_in_decimal, 16), 255);
    g = bit.band(bit.rshift(hex_in_decimal, 8), 255);
    b = bit.band(hex_in_decimal, 255);
  }
end

function rgba_to_rgb(color_hex, background, alpha)
  -- Docs
  -- https://ciechanow.ski/alpha-compositing/
  local c = hex_to_rgb(color_hex);
  local bg = hex_to_rgb(background);
  local new_r = (1 - alpha) * bg.r + alpha * c.r;
  local new_g = (1 - alpha) * bg.g + alpha * c.g;
  local new_b = (1 - alpha) * bg.b + alpha * c.b;
  return string.format("#%02X%02X%02X", new_r, new_g, new_b);
end

function highlight(group, color)
  local style = color.style and 'gui=' .. color.style or 'gui=NONE'
  local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
  local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
  local sp = color.sp and 'guisp=' .. color.sp or ''
  vim.api.nvim_command('highlight ' .. group .. ' ' .. style .. ' ' .. fg .. ' ' .. bg .. ' '.. sp)
end

function make_schema() 
  local colors = {
    none    = 'NONE';
    -- core colors
     orange = '#f79617';
     yellow = '#ffc24b';
     green  = '#84CE5C';
     cyan   = '#50EAFA';
     blue   = '#32b4ff';
     red    = '#ff3c41';
     teal   = '#23D4AC';
     purple = '#a884f3';

     gray0   = '#000111';
     gray1   = '#171831'; --base
     gray2   = '#31324B';
     gray3   = '#4A4B64';
     gray4   = '#64657E';
     gray5   = '#7D7E97';
     gray6   = '#9697B0';
     gray7   = '#B0B1CA';
     gray8   = '#CACBE4';
     gray9   = '#E3E4FD';
     gray10  = '#FCFDFF';

    --extended colors
    red1    = '#ff3b30';
    yellow1 = '#ffcc00';
    blue1   = '#5ac8fa';
  }

  colors.diag = {
    danger  = { fg = colors.red1;    bg = rgba_to_rgb(colors.red1, colors.gray1, 0.16) };
    warning = { fg = colors.yellow1; bg = rgba_to_rgb(colors.yellow1, colors.gray1, 0.16) };
    info    = { fg = colors.blue1;   bg = rgba_to_rgb(colors.blue1, colors.gray1, 0.16) };
    hint    = { fg = colors.blue1;   bg = rgba_to_rgb(colors.blue1, colors.gray1, 0.16) };
  };

  colors.bg            = colors.gray1;
  colors.bg_popup      = rgba_to_rgb(colors.purple, colors.bg, 0.2);
  colors.bg_popup_sel  = rgba_to_rgb(colors.purple, colors.bg_popup, 0.8);
  colors.bg_highlight  = rgba_to_rgb(colors.blue, colors.gray1, 0.3);
  colors.bg_visual     = rgba_to_rgb(colors.blue, colors.gray1, 0.4);
  colors.fg            = colors.gray9;
  colors.fg_disabled   = colors.gray4;
  colors.fg_invert     = colors.gray0;
  colors.fg_popup      = colors.gray9;

  return colors;
end

local schema = make_schema();

local colors = {
  bg = schema.gray2,
  section_bg = schema.gray3,
  fg = schema.gray10,
  grey = schema.gray4,

  orange = schema.orange;
  yellow = schema.yellow;
  green  = schema.green;
  cyan   = schema.cyan;
  blue   = schema.blue;
  red    = schema.red;
  teal   = schema.teal;
  purple = schema.purple;
}

local mode_color_schema = {
  n = colors.purple,
  i = colors.teal,
  c = colors.orange,
  V = colors.blue,
  [''] = colors.blue,
  v = colors.blue,
  R = colors.red,
}

local mode_color = function()
  return mode_color_schema[vim.fn.mode()]
end

local icons = {
    sep = {
        right = "",
        left = ""
    },
    diagnostic = {
        error = " ",
        warn = " ",
        info = " "
    },
    diff = {
        add = " ",
        modified = " ",
        remove = " "
    },
    git = "",
    file = {
      read_only = '',
      modified = '',
    }
}

local white_space = function() return ' ' end

local function file_name(is_active, highlight_group)
  normal_fg = is_active and colors.fg or colors.grey
  modified_fg = is_active and colors.red or colors.orange
  if vim.bo.modifiable then
    if vim.bo.modified then
      vim.api.nvim_command('hi ' .. highlight_group .. ' guifg='.. modified_fg)
    else
      vim.api.nvim_command('hi ' .. highlight_group .. ' guifg='.. normal_fg)
    end
  end
  return fileinfo.get_current_file_name(icons.file.modified, icons.file.read_only)
end

-- --------------------------------------Left side-----------------------------------------------------------
local i = 1
gls.left[i] = {
  FirstElement = {
    provider = function() 
      vim.api.nvim_command('hi GalaxyFirstElement guifg='..mode_color())
      return icons.sep.right
    end,
  },
}

i = i + 1
gls.left[i] = {
  Logo = {
    provider = function()
      vim.api.nvim_command('hi GalaxyLogo guibg='..mode_color())
      return '   ' 
    end,
  },
}

i = i + 1
gls.left[i] = {
  ViMode = {
    provider = function()
      local alias = {
        n       = 'NORMAL ',
        i       = 'INSERT ',
        c       = 'COMMAND',
        V       = 'VISUAL ',
        ['']  = 'VISUAL ',
        v       = 'VISUAL ',
        R       = 'REPLACE',
      }
      vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color()..' gui=bold')
      return '' .. alias[vim.fn.mode()]
    end,
    highlight = { colors.bg, colors.bg },
    -- separator = icons.sep.left,
    -- separator_highlight = {colors.bg, colors.section_bg},
  },
}

i= i + 1
gls.left[i] = {
  ViModeSep = {
    provider = function()
      vim.api.nvim_command('hi GalaxyViModeSep guifg='..mode_color()..' guibg='..colors.section_bg)
      return icons.sep.left .. ' '
    end,
  },
}

i = i + 1
gls.left[i] ={
  FileIcon = {
    provider = {white_space, 'FileIcon'},
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.section_bg },
  },
}

i = i + 1
gls.left[i] = {
  MyFileName = {
    provider = function() return file_name(true, 'GalaxyMyFileName') end,
    highlight = { colors.fg, colors.section_bg },
    separator = icons.sep.left .. ' ',
    separator_highlight = {colors.section_bg, colors.bg}
  }
}

i = i + 1
gls.left[i] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = icons.diagnostic.error,
    highlight = {schema.diag.danger.fg, colors.bg}
  }
}

i = i + 1
gls.left[i] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = icons.diagnostic.warn,
    highlight = {schema.diag.warning.fg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  Space = {
    provider = white_space,
    highlight = {colors.bg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = icons.diagnostic.info,
    highlight = {schema.diag.info.fg, colors.bg},
  }
}

-- ------------------------------------Right side-----------------------------------------------------
local j = 1
gls.right[j] = {
  FirstSeparator = {
    provider = function() return icons.sep.right end,
    highlight = { colors.section_bg, colors.bg },
  }
}

j = j + 1
gls.right[j] = {
  LineInfo = {
    provider = 'LineColumn',
    highlight = { colors.fg, colors.section_bg },
    separator = ' ',
    separator_highlight = { colors.cyan, colors.section_bg },
  },
}

j = j + 1
gls.right[j] = {
  LastElement = {
    provider = function()
      vim.api.nvim_command('hi GalaxyLastElement guifg='..mode_color())
      return icons.sep.left
    end,
  },
}

-- -------------------------Short status line---------------------------------------
local k = 1
gls.short_line_left[k] = {
  SFirstElement = {
    provider = function() return icons.sep.right end,
    highlight = { colors.grey, 'NONE' },
    separator = icons.sep.left,
    separator_highlight = {colors.bg, colors.bg},
  },
}

k = k + 1
gls.short_line_left[k] ={
  SFileIcon = {
    provider = 'FileIcon',
    highlight = { colors.grey, colors.bg },
  },
}

k = k + 1
gls.short_line_left[k] = {
  SMyFileName = {
    provider = function() return file_name(false, 'GalaxySMyFileName') end,
    highlight = {colors.grey, colors.bg},
    separator = icons.sep.left,
    separator_highlight = {colors.bg, colors.bg}
  }
}

k = k + 1
gls.short_line_right[k] = {
  SLastElement = {
    provider = function() return icons.sep.left end,
    highlight = { colors.grey, 'NONE' }
  },
}
