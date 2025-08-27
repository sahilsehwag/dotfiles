--------------------------------
-- SETUP
--------------------------------

-- resolve current file directory
local current_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
local lua_dir = current_dir .. "lua/?.lua;" .. current_dir .. "lua/?/init.lua;"

-- extend lua's package path
package.path = lua_dir .. package.path
--package.path = "~/.config/nvim/custom;" .. package.path

-- sourcing the init.vim file
vim.cmd("source " .. current_dir .. "init.vim")

--------------------------------
-- CONFIG
--------------------------------
vim.notify = require('vscode').notify

--------------------------------
-- LIBS FIX:
--------------------------------
--require('lib.funk')
--require('lib.func')

--------------------------------
-- MAPPINGS
--------------------------------
require('jaat.mappings')

--------------------------------
-- PLUGINS
--------------------------------

require('jaat.plugins.lazy')
