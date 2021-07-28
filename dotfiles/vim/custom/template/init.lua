local utils = require('libs.utils')
local merge = utils.table.dict.merge

local helpers = require('template.helpers')
local renderers = require('template.renderers')

local CONFIG = require('template.config')

return {
	setup = function(config)
    CONFIG = merge({ CONFIG, config or {} })
    
		vim.g.template = { config = CONFIG }
	end,
}
