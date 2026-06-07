-- providers/init.lua
local M = {}

local registry = {
	omp    = 'agentify.providers.omp',
	claude = 'agentify.providers.claude',
	pi     = 'agentify.providers.pi',
}

-- Returns the provider module for name, falling back to omp.
function M.get(name)
	local mod = registry[name] or registry.omp
	return require(mod)
end

return M
