luasnip = require('luasnip')
local snippet     = luasnip.snippet
local snippetNode = luasnip.snippet_node
local textNode    = luasnip.text_node
local insertNode  = luasnip.insert_node
local functionNode = luasnip.function_node
local choiceNode  = luasnip.choice_node
local dynamicNode = luasnip.dynamic_node
local lambda      = require("luasnip.extras").lambda
local rep         = require("luasnip.util.functions").rep
local partial     = require("luasnip.util.functions").partial

return {
  --definitions
  --variables
  --functions
  --classes
  --methods
  --types
  --type
  --interface

  --api
  snippet('api.console.log', {
    textNode('console.log('),
    insertNode(1),
    textNode(')'),
  }),
}
