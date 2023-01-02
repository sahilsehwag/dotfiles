require("telescope-alternate").setup({
	-- Telescope pre-defined mapping presets
	presets = {},
	-- custom transformers
	transformers = {
		--change_to_uppercase = function(w)
			--return my_uppercase_method(w)
		--end,
	},
  --FIX:
	mappings = {
		{ "src/.*/(.*).ts", {
			{ "src/**/__tests__/[1].spec.ts", "Test" },
			{ "src/**/__fixtures__/[1].ts", "Fixture" },
			{ "src/**/__mocks__/[1].ts", "Mock" },
		}},
		{ "__tests__/**/(.*).(spec|test).(ts|js|tsx|jsx)", {
			{ "[1].(ts|js|tsx|jsx)", "Source" },
		}},
	},
})

-- On your telescope:
require("telescope").load_extension("telescope-alternate")
