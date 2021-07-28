local merge = require('libs.utils').table.dict.merge

return merge({
	require('pacman.pacmans'),
	{ cmds = { terminal = 'split | terminal' } }
})
