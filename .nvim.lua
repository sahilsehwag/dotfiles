-- write luansnip snippet for lua filetype
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("lua", {
  s("plug", fmt(
    [[
    ["{}"] = {{
      url = "{}",
      is_enabled = function()
        return vim.fn.has("{}") == 1
      end,
      dependencies = {{
        pre = {{ {} }},
      }},
    }},
    ]],
    {
      i(1, "author/repo"),
      i(2, "author/repo"),
      i(3, "nvim-0.5"),
      i(4, ""),
    }
  )),
})
