--custom functions on buffer
--require('bufferline').exec(
--  4, -- the forth visible buffer from the left
--  user_function -- an arbitrary user function which gets passed the buffer
--)

---- e.g.
--function _G.bdel(num)
--  require('bufferline').exec(num, function(buf, visible_buffers)
--    vim.cmd('bdelete '..buf.id)
--  end
--end

--vim.cmd [[
--  command -count Bdel <Cmd>lua _G.bdel(<count>)<CR>
--]]
