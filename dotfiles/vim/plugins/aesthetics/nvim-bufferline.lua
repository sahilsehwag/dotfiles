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

require('bufferline').setup({
  highlights = {
    fill = {
      guibg = '#282828',
    },
    buffer_selected = {
      gui = 'NONE',
    },
    --separator_selected = {
    --  guifg = '#282828',
    --},
    --separator_visible = {
    --  guifg = '#282828',
    --},
    --separator = {
    --  guifg = '#282828',
    --},
  },
  options = {
    mappings               = false,
    numbers                = 'none',
    number_style           = 'none',
    max_name_length        = 20,
    max_prefix_length      = 16, -- prefix used when a buffer is de-duplicated
    tab_size               = 28,
    enforce_regular_tabs   = false,
    always_show_bufferline = true,

    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
        return true
      end
    end,

    --offsets
    --offsets = {{filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' | 'center' | 'right'}},
    offsets = {{
      filetype   = 'NvimTree',
      text       = 'File Explorer',
      text_align = 'center',
    }},

    --icons
    --indicator_icon     = '?',
    --buffer_close_icon  = '?',
    --modified_icon      = '?',
    --close_icon         = '?',
    --left_trunc_marker  = '◤',
    --right_trunc_marker = '◥',
      -- NOTE: this plugin is designed with this icon in mind,
      -- and so changing this is NOT recommended, this is intended
      -- as an escape hatch for people who cannot bear it for whatever reason
    show_buffer_icons       = true,
    show_buffer_close_icons = true,
    show_close_icon         = true,
    show_tab_indicators     = true,

    --sorting
    persist_buffer_sort = true,
    sort_by = 'directory',
      --sort_by = 'extension' | 'relative_directory' | 'directory' | function(buffer_a, buffer_b)

    --separators
    separator_style = 'thin',
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      --separator_style = 'slant' | 'thick' | 'thin' | { 'any', 'any' },

    --diagnostics
    --diagnostics = 'nvim_lsp',
    diagnostics = 'none',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return '('..count..')'
    end,
    diagnostic = {
      guifg = comment_diagnostic_fg,
      guibg = background_color,
    },
    diagnostic_visible = {
      guifg = comment_diagnostic_fg,
      guibg = visible_bg,
    },
    diagnostic_selected = {
      guifg = normal_diagnostic_fg,
      guibg = normal_bg,
      gui = 'bold,italic',
    },
    info = {
      guifg = comment_fg,
      guisp = info_fg,
      guibg = background_color,
    },
    info_visible = {
      guifg = comment_fg,
      guibg = visible_bg,
    },
    info_selected = {
      guifg = info_fg,
      guibg = normal_bg,
      gui = 'bold,italic',
      guisp = info_fg,
    },
    info_diagnostic = {
      guifg = comment_diagnostic_fg,
      guisp = info_diagnostic_fg,
      guibg = background_color,
    },
    info_diagnostic_visible = {
      guifg = comment_diagnostic_fg,
      guibg = visible_bg,
    },
    info_diagnostic_selected = {
      guifg = info_diagnostic_fg,
      guibg = normal_bg,
      gui = 'bold,italic',
      guisp = info_diagnostic_fg,
    },

    custom_areas = {
      right = function()
        local result = {}

        local error   = vim.lsp.diagnostic.get_count(0, [[Error]])
        local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        local info    = vim.lsp.diagnostic.get_count(0, [[Information]])
        local hint    = vim.lsp.diagnostic.get_count(0, [[Hint]])

        --if error ~= 0 then
        --  result[1] = {
        --    text = '  ' .. error,
        --    guifg = '#EC5241',
        --  }
        --end

        --if warning ~= 0 then
        --  result[2] = {
        --    text = '  ' .. warning,
        --    guifg = '#EFB839',
        --  }
        --end

        --if hint ~= 0 then
        --  result[3] = {
        --    text = '  ' .. hint,
        --    guifg = '#A3BA5E',
        --  }
        --end

        --if info ~= 0 then
        --  result[4] = {
        --    text = '  ' .. info,
        --    guifg = '#7EA9A7',
        --  }
        --end
        return result
      end
    },
  },
})
