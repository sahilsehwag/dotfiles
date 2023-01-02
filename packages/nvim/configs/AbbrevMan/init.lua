local abbrev_man = require'abbrev-man'

abbrev_man.setup({
	load_natural_dictionaries_at_startup = true,
	load_programming_dictionaries_at_startup = true,
	natural_dictionaries = {
		['nt_en'] = require'configs.AbbrevMan.en',
	},
	programming_dictionaries = {
		['pr_lua'] = require'configs.AbbrevMan.lua',
		['pr_js'] = require'configs.AbbrevMan.js',
	}
})
