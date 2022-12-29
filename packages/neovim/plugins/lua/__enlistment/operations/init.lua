local default = {
	name = nil,
	description = nil,

	adders     = {},
	sources    = {},
	sorters    = {},
	matchers   = {},
	handlers   = {},
	filterers  = {},
	previewers = {},
	renderers  = {},
	formatters = {},

	themes	= {},
	layouts = {},
}

return function(config)
	config = F.vim.get_config(default, config or {})
end
