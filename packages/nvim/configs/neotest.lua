require('neotest').setup({
  adapters = {
    require('neotest-jest')({}),
  },
})

F.vim.nmap('<leader>ltn', require('neotest').run.run)
F.vim.nmap('<leader>lts', require('neotest').run.stop)
F.vim.nmap('<leader>lta', require('neotest').run.attach)

F.vim.nmap('<leader>ltf', function()
  require('neotest').run.run(vim.fn.expand('%'))
end)

--require('neotest').run.run({strategy = 'dap'})
