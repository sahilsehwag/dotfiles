-- selection.lua
local M = {}

function M.visual()
	local s = vim.fn.getpos("'<")
	local e = vim.fn.getpos("'>")
	return { start_line = s[2], end_line = e[2] }
end

function M.line()
	local l = vim.fn.line('.')
	return { start_line = l, end_line = l }
end

function M.file()
	return { start_line = 1, end_line = vim.api.nvim_buf_line_count(0) }
end

return M
