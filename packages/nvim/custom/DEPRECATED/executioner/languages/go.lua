
return {
	config = {
		defaults = {
			linters = 'golangci_lint',
		},
	},
	extenisons = { 'go' },
	filetypes = { 'go' },
	linters = {
		default = 'golangci_lint',
		golangci_lint = 'golangci_lint',
	},
}
