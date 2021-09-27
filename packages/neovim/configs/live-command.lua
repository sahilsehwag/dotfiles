require'live-command'.setup({
	defaults = {
    enable_highlighting = true,
    inline_highlighting = true,
    hl_groups = {
      insertion = "DiffAdd",
      deletion = "DiffDelete",
      change = "DiffChange",
    },
    debug = false,
  },
	commands = {
		Norm = { cmd = 'norm' },
	},
})
