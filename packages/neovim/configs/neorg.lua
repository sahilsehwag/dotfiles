require('neorg').setup({
	load = {
		["core.defaults"] = {}, -- Load all the default modules
		["core.norg.concealer"] = {}, -- Allows for use of icons
		["core.norg.dirman"] = { -- Manage your directories with Neorg
			config = {
				workspaces = {
					default = vim.g.jaat_tmp_path .. 'neorg'
				},
			},
		},
		["core.keybinds"] = { -- Configure core.keybinds
			config = {
				default_keybinds = true, -- Generate the default keybinds
				neorg_leader = "<LocalLeader>o" -- This is the default if unspecified
			},
		},
	},
})
