local utils = require('libs.utils')
local merge = utils.table.dict.merge

local CONFIG = require('macroni.config')

return {
	setup = function(config)
    CONFIG = merge({ CONFIG, config or {} })
		vim.g.macroni = { config = CONFIG }
	end,
}
