local gps = require('nvim-gps')

require('galaxyline').section.left[1]= {
	nvimGPS = {
		provider = function()
			return gps.get_location()
		end,
		condition = function()
			return gps.is_available()
		end
	}
}
