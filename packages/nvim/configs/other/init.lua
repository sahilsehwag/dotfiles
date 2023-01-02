require("other-nvim").setup({
	mappings = F.concat_all({
		{
			"livewire",
			"angular",
			"laravel",
			"rails",
		},
		require("configs.other.javascript"),
	}),
	transformers = {
		-- defining a custom transformer
		lowercase = function(inputString)
			return inputString:lower()
		end,
	},
	style = {
		-- How the plugin paints its window borders
		-- Allowed values are none, single, double, rounded, solid and shadow
		border = "single",

		-- Column seperator for the window
		seperator = "|",

		-- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
		width = 0.7,

		-- min height in rows.
		-- when more columns are needed this value is extended automatically
		minHeight = 2,
	},
})

F.vim.nmap(
	"<LocalLeader>`",
	"<cmd>Other<CR>",
	{ desc = "open-alternative-file" }
)

F.vim.nmap(
	"<LocalLeader>~",
	function()
		vim.cmd 'OtherClear'
		vim.cmd 'Other'
	end,
	{ desc = "OtherClear" }
)
