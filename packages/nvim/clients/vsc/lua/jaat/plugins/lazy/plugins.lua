require("lazy").setup({
  spec = {
    { "lewis6991/impatient.nvim", },
    { "tpope/vim-capslock", },
    { "kana/vim-repeat" },
    { "kana/vim-niceblock", },
    { "smjonas/live-command.nvim", },

    -- grammar
    { "thalesmello/nvim-better-operator-message", },
    { "wellle/targets.vim", },
    {
      "kana/vim-operator-user",
      dependencies = {
        "osyo-manga/vim-operator-blockwise",
        "kana/vim-operator-replace",
        "rjayatilleka/vim-operator-goto",
        "osyo-manga/vim-operator-search",
        "vim-scripts/operator-star",
        "haya14busa/vim-operator-flashy",
        {
          "gustavo-hms/vim-duplicate",
          keys = {
            { "gy", "<plug>(operator-duplicate)", desc = "operator-duplicate"},
          },
        },
      },
    },
    {
      "kana/vim-textobj-user",
      dependencies = {
        "osyo-manga/vim-textobj-blockwise",
        "coderifous/textobj-word-column.vim",
        "rhysd/vim-textobj-anyblock",
        "thinca/vim-textobj-between",
        "saaguero/vim-textobj-pastedtext",
        "rhysd/vim-textobj-lastinserted",
        "Julian/vim-textobj-variable-segment",
        "machakann/vim-textobj-delimited",
        "syngan/vim-textobj-postexpr",
        "thalesmello/vim-textobj-methodcall",
        "glts/vim-textobj-comment",
        "justinj/vim-textobj-reactprop",
      },
    },

		{"chaoren/vim-wordmotion" },
    { "jonatan-branting/nvim-better-n", },
    { "kylechui/nvim-surround", },
    { "svermeulen/vim-subversive", },
    { "tommcdo/vim-exchange", },
    { "junegunn/vim-easy-align", },
    { "JRasmusBm/vim-peculiar", },
    { "kana/vim-grex", },
    { "arthurxavierx/vim-caser", },
    { "tommcdo/vim-ninja-feet", },
    { "terryma/vim-multiple-cursors", },
    { "michaeljsmith/vim-indent-object", },
    { "Raimondi/vim_search_objects", },
    { "machakann/vim-swap", },

    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require('configs.nvim-treesitter')
      end,
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "David-Kunz/treesitter-unit",
      }
    },
  },
})
