return {
	config = {
		defaults = {
			runners = 'java',
			compilers = 'javac',
			repls = 'jshell',
		},
	},
	extenisons = { 'java' },
	filetypes = {
		'java',
	},
	runners = {
		java = 'java --enable-preview',
	},
	compilers = {
		javac = 'javac',
	},
	repls = {
		jshell = 'jshell',
	},
}
