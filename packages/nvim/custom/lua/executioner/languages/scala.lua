return {
	config = {
		defaults = {
			runners = 'scala',
			compilers = 'scalac',
			repls = 'scala',
		},
	},
	extenisons = { 'scala' },
	filetypes = {
		'scala',
	},
	runners = {
		scala = 'scala --enable-preview',
	},
	compilers = {
		scalac = 'scalac',
	},
	repls = {
		scala = 'scala',
	},
}
