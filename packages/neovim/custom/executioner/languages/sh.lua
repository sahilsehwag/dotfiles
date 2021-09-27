return {
	config = {
		defaults = {
			repls = 'zsh',
			runners = 'bash',
      formatters = 'shfmt',
		},
	},
	extenisons = {
		'sh',
		'bash',
		'zsh',
	},
	filetypes = {
		'sh',
		'bash',
		'zsh',
	},
  formatters = {
		shfmt = 'shfmt -w',
  },
	runners = {
		sh = 'sh -x',
		bash = 'bash',
		zsh = 'zsh -x',
	},
	repls = {
		sh = 'sh',
		bash = 'bash',
		zsh = 'zsh',
	},
}
