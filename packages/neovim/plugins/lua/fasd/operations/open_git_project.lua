return F.pipe(
	F.rf('fasd.utilities.get_git_dirs'),
	F.vim.select_directory({})
)
