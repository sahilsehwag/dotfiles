require("neorg").setup({
	icon_preset = "basic",
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
		["core.concealer"] = {}, -- Adds pretty icons to your documents
		["core.dirman"] = { -- Manages Neorg workspaces
			config = {
				workspaces = {
					work = "~/Documents/notes/work",
				},
			},
		},
	},
})
