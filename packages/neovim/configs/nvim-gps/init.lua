require'nvim-gps'.setup({
	icons = {
		["class-name"] = '  ',      -- Classes and class-like objects
		["function-name"] = '  ',   -- Functions
		["method-name"] = '  '      -- Methods (functions inside class-like objects)
	},
	languages = {                    -- You can disable any language individually here
		["c"] = true,
		["cpp"] = true,
		["go"] = true,
		["java"] = true,
		["javascript"] = true,
		["typescript"] = true,
		["lua"] = true,
		["python"] = true,
		["rust"] = true,
	},
	separator = ' ',
})

