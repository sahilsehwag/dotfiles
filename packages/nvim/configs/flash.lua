require("flash").setup()

--vim.keymap.set(
--  { "n", "o", "x" },
--  "s",
--  function() require("flash").jump() end
--)

vim.keymap.set(
	{ "n", "o", "x" },
	"S",
	function() require("flash").treesitter() end
)

vim.keymap.set(
	{ "o" },
	"gr",
	function() require("flash").remote() end
)

vim.keymap.set(
	{ "o", "x" },
	"gt",
	function() require("flash").treesitter_search() end
)

--vim.keymap.set(
--  { "c" },
--  "<c-s>",
--  function() require("flash").toggle() end
--)
