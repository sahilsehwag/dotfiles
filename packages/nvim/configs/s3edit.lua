require's3edit'.setup({
	exclude = { ".git", ".hoodie", ".parquet", ".zip" },
	autocommand_events = { "BufWritePost" },
})
