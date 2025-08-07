return {
	config = {
		defaults = {
			linters = 'golangci_lint',
			compilers = 'go',
			runners = 'go',
			testers = 'go',
			formatters = 'go',
		},
	},
	extenisons = { 'go' },
	filetypes = { 'go' },
	linters = {
		default = 'golangci_lint',
		golangci_lint = 'golangci_lint',
	},
	compilers = {
		go = 'go build',
	},
	runners = {
    go = 'go run',
	},
	formatters = {
		go = 'go fmt',
	},
	testers = {
		go = 'go test',
	},
}
