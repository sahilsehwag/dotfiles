--------------------------------
-- SETUP
--------------------------------

-- resolve current file directory
local current_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
local lua_dir = current_dir .. "lua/?.lua;" .. current_dir .. "lua/?/init.lua;"

-- extend lua's package path
package.path = lua_dir .. package.path

-- sourcing the init.vim file
vim.cmd("source " .. current_dir .. "init.vim")

--------------------------------
-- CONFIG
--------------------------------

require('jaat.plugins.lazy')

--------------------------------
-- PLUGINS
--------------------------------
