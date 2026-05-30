return {
	config = {
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
					unusedwrite  = true,
					shadow       = true,
				},
				staticcheck     = true,
				gofumpt         = true,
				usePlaceholders = true,
			},
		},
	},
}
