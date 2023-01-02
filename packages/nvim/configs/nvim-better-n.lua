require'better-n'.setup{
	-- These are default values, which can be omitted.
	-- By default, the following mappings are made repeatable using `n` and `<S-n>`:
	-- `f`, `F`, `t`, `T`, `*`, `#`, `/`, `?`
	disable_default_mappings = false,
}

vim.api.nvim_create_autocmd("User", {
  pattern = "BetterNMappingExecuted",
  callback = function(args)
    -- args.data.key and args.data.mode are available here
		vim.cmd [[ nohl ]]
  end
})

-- You create repeatable mappings like this:
local hunk_navigation = require("better-n").create(
  {
    next =  require("gitsigns").next_hunk,
    previous = require("gitsigns").prev_hunk
  }
)

vim.keymap.set({ "n", "x" }, "]g", hunk_navigation.next)
vim.keymap.set({ "n", "x" }, "[g", hunk_navigation.previous)

-- TODO:
--['[x'] = {previous = '[x', next = ']x'},
--[']x'] = {previous = '[x', next = ']x'},

--['[q'] = {previous = '[q', next = ']q'},
--[']q'] = {previous = '[q', next = ']q'},

-- I have <leader>hn/hp bound to git-hunk-next/prev
--['<leader>hn'] = {previous = '<leader>hp', next = '<leader>hn'},
--['<leader>hp'] = {previous = '<leader>hp', next = '<leader>hn'},

-- I have <leader>bn/bp bound to buffer-next/prev
--['<leader>bn'] = {previous = '<leader>bp', next = '<leader>bn'},
--['<leader>bp'] = {previous = '<leader>bp', next = '<leader>bn'},
