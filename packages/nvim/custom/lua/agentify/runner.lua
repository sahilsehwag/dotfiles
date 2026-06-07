-- runner.lua
local Badge = require('agentify.badge')

local M = {}

function M.run(argv, label, provider)
	local badge = Badge.new()
	local prefix = 'Agentify(' .. label .. ')'
	badge:set(prefix .. '…')

	local all_lines = {}
	local err_lines = {}

	local handle_event = function(line)
		if line == '' then return end
		local ok, ev = pcall(vim.fn.json_decode, line)
		if not ok or type(ev) ~= 'table' then return end
		local status = provider.parse_event(ev)
		if status then
			badge:set(prefix .. ': ' .. status)
		elseif ev.type == 'tool_execution_end' then
			badge:set(prefix .. '…')
		end
	end

	vim.fn.jobstart(argv, {
		stdout_buffered = true,
		stderr_buffered = true,

		on_stdout = function(_, data)
			for _, line in ipairs(data or {}) do
				all_lines[#all_lines + 1] = line
			end
		end,

		on_stderr = function(_, data)
			for _, line in ipairs(data or {}) do
				if line ~= '' then err_lines[#err_lines + 1] = line end
			end
		end,

		on_exit = function(_, code)
			for _, line in ipairs(all_lines) do
				handle_event(line)
			end
			badge:close()
			vim.schedule(function()
				if code == 0 then
					for _, b in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_loaded(b) then
							vim.api.nvim_buf_call(b, function()
								vim.cmd('silent! checktime')
							end)
						end
					end
					vim.notify(prefix .. ': Done', vim.log.levels.INFO)
				else
					local tail = {}
					for i = math.max(1, #err_lines - 5), #err_lines do
						tail[#tail + 1] = err_lines[i]
					end
					vim.notify(
						prefix .. ': Failed (exit ' .. code .. ')\n' .. table.concat(tail, '\n'),
						vim.log.levels.ERROR
					)
				end
			end)
		end,
	})
end

return M
