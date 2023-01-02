local tsj   = require('treesj')
local utils = require('treesj.langs.utils')

local javascript = require('treesj.langs.javascript')
local typescript = require('treesj.langs.typescript')
--local jsx = require('treesj.langs.jsx')
--local tsx = require('treesj.langs.tsx')
local html = require('treesj.langs.html')

tsj.setup({
  -- Use default keymaps
  -- (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = false,

  -- Node with syntax error will not be formatted
  check_syntax_error = true,

  -- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 200,

  -- hold|start|end:
  -- hold - cursor follows the node/place on which it was called
  -- start - cursor jumps to the first symbol of the node being formatted
  -- end - cursor jumps to the last symbol of the node being formatted
  cursor_behavior = 'hold',

  -- Notify about possible problems or not
  notify = true,
  langs = {
		html       = utils.merge_preset(html, {}),
		javascript = utils.merge_preset(javascript, {}),
		typescript = utils.merge_preset(typescript, {}),
		jsx        = utils.merge_preset(javascript, {}),
		tsx        = utils.merge_preset(typescript, {}),
  },
})

F.vim.nmap('gJ', ' <CMD>TSJJoin<CR>')
F.vim.nmap('gS', ' <CMD>TSJSplit<CR>')
