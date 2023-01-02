vim.cmd [[ nmap <leader>lrd :lua require('nvim-redux').list_dispatch_calls()<CR> ]]
vim.cmd [[ nmap <leader>lra :lua require('nvim-redux').list_actions_in_switch_reducer()<CR> ]]
