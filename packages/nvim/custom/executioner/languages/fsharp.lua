return {
	config = {
		defaults = {
			runners = 'dotnet',
			repls = 'dotnet',
		},
	},
	extenisons = { 'fs', 'fsx' },
	filetypes = { 'fsharp' },
	runners = { dotnet = 'dotnet fsi' },
	repls = { dotnet = 'dotnet fsi' },
}
