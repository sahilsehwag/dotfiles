types
	search(/)
		entire-file
		uniredirectional
		modes
			jump|stay
			filter(single|multi-line context)
			easymotion-like highlight
			invisible mode (non-matches are not shown)
	jump(f)
		visible-file
		biredirectional
		line|block(lsp|treesitter)
	next(*)
		biredirectional
		automatic-markers
rendering (easymotion)
	marker
		virtual line (above|belo)
		virtual markers(left|right|top|bottom)
		grey-out other text
			in case of markers not on top, grey out everthing except match|word|line|WORD...
		1-9
		<C-*> control mappings
		<LocalLeader> mappings
		marker-paginations
			marker-page navigate(C-d, C-f)
			[] foo prev|next page
		modes
			line|word|end.....identifier|functions...
principles
	non-obtrusive (search/markers are displayed, then jump)
