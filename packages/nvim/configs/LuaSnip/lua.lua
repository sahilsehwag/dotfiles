local luasnip       = require('luasnip')
local snippet       = luasnip.snippet
local snippet_node  = luasnip.snippet_node
local text_node     = luasnip.text_node
local insert_node   = luasnip.insert_node
local function_node = luasnip.function_node
local choice_node   = luasnip.choice_node
local dynamic_node  = luasnip.dynamic_node
local lambda        = require("luasnip.extras").lambda
local rep           = require("luasnip.util.functions").rep
local partial       = require("luasnip.util.functions").partial

return {
  --definitions
  --variables
  --functions

  --expressions
  snippet('expression.type', {
    text_node('type('),
    insert_node(1),
    text_node(") == '"),
    insert_node(2),
    text_node("'"),
  }),
  snippet('expression.type.table', {
    text_node('type('),
    insert_node(1),
    text_node(") == 'table'"),
  }),
  snippet('expression.type.string', {
    text_node('type('),
    insert_node(1),
    text_node(") == 'string'"),
  }),
  snippet('expression.type.nil', {
    text_node('type('),
    insert_node(1),
    text_node(") == 'nil'"),
  }),
  snippet('expression.type.function', {
    text_node('type('),
    insert_node(1),
    text_node(") == 'function'"),
  }),

  --api.lua
  snippet('api.require', {
    text_node("require('"),
    insert_node(1),
    text_node("')"),
  }),

  snippet('api.print', {
    text_node('print('),
    insert_node(1),
    text_node(')'),
  }),
  snippet('api.print.string', {
    text_node("print('"),
    insert_node(1),
    text_node("')"),
  }),

  --api.nvim
  snippet('api.nvim.inspect', {
    text_node('vim.inspect('),
    insert_node(1),
    text_node(')'),
  }),
}
