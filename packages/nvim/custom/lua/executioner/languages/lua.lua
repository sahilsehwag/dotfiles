return {
	config = {
		defaults = {
			runners = "lua",
			repls = "lua",
			formatters = "stylua",
		},
	},
	extenisons = { "lua" },
	filetypes = { "lua" },
	formatters = {
		stylua = "stylua",
	},
	runners = {
		lua = "lua",
		source = "source",
		luafile = "luafile",
	},
	repls = {
		lua = "lua",
		luapad = "Luapad",
	},
}
