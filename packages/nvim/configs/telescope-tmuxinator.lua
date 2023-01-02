require("telescope").load_extension("tmuxinator")

F.vim.nmap("<Leader>mp", function()
	require("telescope")
		.extensions
		.tmuxinator
		.projects(
			require("telescope.themes").get_dropdown({})
		)
end, { desc = "projects" })
