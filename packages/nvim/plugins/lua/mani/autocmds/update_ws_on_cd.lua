--vim.cmd [[
--  augroup UPDATE_WS_ON_CD
--    autocmd!
--    autocmd DirChanged * lua require'neovim.mani.autocmds'.update_ws_on_cd()
--]]