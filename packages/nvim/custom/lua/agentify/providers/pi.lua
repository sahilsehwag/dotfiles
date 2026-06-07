-- providers/pi.lua
local M = {}

function M.build_argv(config, opts)
	local args = (config.sdk_args or {}).pi or {}
	local argv = { 'pi', '-p' }
	for _, a in ipairs(args) do
		if a ~= '' then argv[#argv + 1] = a end
	end
	return argv
end

function M.parse_event(_ev) return nil end

function M.find_session(_root) return nil end

return M
