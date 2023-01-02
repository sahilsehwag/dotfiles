require('modes').setup({
  colors = {
    copy = "#f5c359",
    delete = "#c75c6a",
    insert = "#78ccc5",
    visual = "#9745be",
  },
  line_opacity = 0.1
})

-- Or use highlight groups (useful for themes)
vim.cmd('hi ModesCopy guibg=#f5c359')
vim.cmd('hi ModesDelete guibg=#c75c6a')
vim.cmd('hi ModesInsert guibg=#78ccc5')
vim.cmd('hi ModesVisual guibg=#9745be')
