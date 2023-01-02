F.rt'fasd'.setup()

F.vim.nmap('<leader>po', F.rt'fasd'.open_project)

--local open_nvim = function(dir)
--  if dir then
--    F.vim.open_nvim_in_tmux{pwd=dir}
--  end
--end

--F.vim.nmap('<leader>mo', function()
--  require'fasd'.open_project(open_nvim)
--end)
