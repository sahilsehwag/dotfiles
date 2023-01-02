require'barbecue'.setup({
  ---whether to attach navic to language servers automatically
  ---@type boolean
  attach_navic = true,

  ---whether to create winbar updater autocmd
  ---@type boolean
  create_autocmd = true,

  ---buftypes to enable winbar in
  ---@type string[]
  --include_buftypes = { },

  ---filetypes not to enable winbar in
  ---@type string[]
  exclude_filetypes = {
    'toggleterm',
    'telescope',
    'terminal',
    'floaterm',
    'fzf',
    'spectre_panel',
    'prompt',
    'TelescopePrompt',
    'vista_kind',
    'Trouble',
    'nvimtree',
    'help',
    'nofile',
    'dirbuf',
  },

  ---returns a string to be shown at the end of winbar
  ---@type fun(bufnr: number): string
  custom_section = function()
    return ""
  end,

  modifiers = {
    ---filename modifiers applied to dirname
    ---@type string
    dirname = ":~:.",

    ---filename modifiers applied to basename
    ---@type string
    basename = "",
  },

  ---icons used by barbecue
  ---@type table<string, string>
  symbols = {
    ---entry separator
    ---@type string
    separator = "►",

    ---modification indicator
    ---`false` to disable
    ---@type false|string
    modified = false,

    ---@deprecated
    --default_context = nil,
  },

  ---icons for different context entry kinds
  ---@type table<string, false|string>
  kinds = {
    Package       = "",
    Namespace     = "",
    Macro         = "",
    Field         = "",
    Event         = "",
    TypeParameter = "",
    Operator      = "",
    Null          = "",
    Boolean       = "B",
    Number        = "N",
    String        = "",
    Key           = " ",
    Array         = '[]',
    Object        = '{}',
    Text          = '  ',
    Method        = '',
    Function      = '',
    Constructor   = '  ',
    Variable      = '[]',
    Class         = '  ',
    Interface     = '  ',
    Module        = ' פּ ',
    Property      = '  ',
    Unit          = ' 塞 ',
    Value         = '  ',
    Enum          = ' 練',
    Keyword       = '  ',
    Snippet       = '  ',
    Color         = '  ',
    File          = '  ',
    Folder        = ' ﱮ ',
    EnumMember    = '  ',
    Constant      = '  ',
    Struct        = '  '
  },
})
