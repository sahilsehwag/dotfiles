return {
	config = {
		defaults = {
			runners = 'exe',
			compilers = 'ghc',
			repls = 'ghci',
		},
	},
	extenisons = { 'haskell' },
	filetypes = { 'hs' },
	runners = {
		exe = '',
	},
	compilers = {
		ghc = 'ghc -Wno-tabs',
	},
	repls = {
		ghci = 'ghci',
	},
}
