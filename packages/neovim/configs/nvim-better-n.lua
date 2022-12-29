require'better-n'.setup{
	callbacks = {
		mapping_executed = function(_mode, _key)
			-- Clear highlighting, indicating that `n` will not goto the next
			-- highlighted search-term
			vim.cmd [[ nohl ]]
		end
	},
	mappings = {
		-- I want `n` to always go forward, and `<s-n>` to always go backwards
		['*'] = {previous = '<s-n>', next = 'n'},
		['#'] = {previous = 'n', next = '<s-n>'},
		['f'] = {previous = ',', next = ';'},
		['t'] = {previous = ',', next = ';'},
		['F'] = {previous = ';', next = ','},
		['T'] = {previous = ';', next = ','},

		['/'] = {previous = 'n', next = '<s-n>', cmdline = true},
		['?'] = {previous = '<s-n>', next = 'n', cmdline = true},

		--not working
		['[g'] = {previous = '[g', next = ']g'},
		[']g'] = {previous = '[g', next = ']g'},

		['[x'] = {previous = '[x', next = ']x'},
		[']x'] = {previous = '[x', next = ']x'},

		['[q'] = {previous = '[q', next = ']q'},
		[']q'] = {previous = '[q', next = ']q'},

		-- Setting `cmdline = true` ensures that `n` will only be
		-- overwritten if the search command is succesfully executed

		-- I have <leader>hn/hp bound to git-hunk-next/prev
		--['<leader>hn'] = {previous = '<leader>hp', next = '<leader>hn'},
		--['<leader>hp'] = {previous = '<leader>hp', next = '<leader>hn'},

		-- I have <leader>bn/bp bound to buffer-next/prev
		--['<leader>bn'] = {previous = '<leader>bp', next = '<leader>bn'},
		--['<leader>bp'] = {previous = '<leader>bp', next = '<leader>bn'},
	}
}

F.vim.nmap('n',     require'better-n'.n,       {nowait = true})
F.vim.nmap('<s-n>', require'better-n'.shift_n, {nowait = true})
