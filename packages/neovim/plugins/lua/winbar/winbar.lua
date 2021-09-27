local ThemeManager   = require('winbar.theme.theme-manager')
local HighlightGroup = require('winbar.highlighting.highlight-groups')
local Highlighter    = require('winbar.highlighting.highlighter')

local theme = ThemeManager.get_theme()

local M = {}

local highlights = HighlightGroup({
  WinBarSeparator = { guifg = theme.bright.white },
  WinBarContent = { guifg = theme.bright.black, guibg = theme.bright.white },
  WinBarContentModified = {
    guifg = theme.bright.red,
    guibg = theme.bright.white,
  },
})

Highlighter:new():add(highlights):register_highlights()

local ignore = {
  'term',
  'NvimTree',
  'Spectre',
  '%[Scratch%]',
  '%[Prompt%]',
  '/bin/fzf',
  '.*Bqf.*',
  '%[.*%]'
}

M.eval = function()
  local file_path = vim.api.nvim_eval_statusline('%f', {}).str
  local modified = vim.api.nvim_eval_statusline('%m', {}).str == '[+]'
    and '  ⟴  '
    or ''

  --file_path = file_path:gsub('/', ' ➤ ')

  for _, v in ipairs(ignore) do
    if F.match(v, file_path) then
      return ' '
    end
  end

  return '%#WinBarSeparator#'
    .. ''
    --.. '█'
    .. '%*'
    .. '%#WinBarContent#'
    .. file_path
    .. '%*'
    .. '%#WinBarContentModified#'
    .. modified
    .. '%*'
    .. '%#WinBarSeparator#'
    .. ''
    --.. ''
    .. '%*'
end

return M
