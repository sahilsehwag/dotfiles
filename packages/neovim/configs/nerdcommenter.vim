"CONFIGURATION
	let g:NERDCreateDefaultMappings  = 0
	let g:NERDSpaceDelims            = 0
	let g:NERDCompactSexyComs        = 1
	let g:NERDDefaultAlign           = 'left'
	let g:NERDAltDelims_java         = 1
	let g:NERDCustomDelimiters       = { 'c': { 'left': '/**','right': '*/' } }
	let g:NERDCommentEmptyLines      = 0
	let g:NERDTrimTrailingWhitespace = 1
	let g:NERDToggleCheckAllLines    = 1
"MAPPINGS
	nmap gkt <plug>NERDCommenterToggle
	xmap gkt <plug>NERDCommenterToggle

	nmap gkc <plug>NERDCommenterComment
	xmap gkc <plug>NERDCommenterComment

	nmap gku <plug>NERDCommenterUncomment
	xmap gku <plug>NERDCommenterUncomment

	xmap gki <plug>NERDCommenterInvert
	xmap gky <plug>NERDCommenterYank

	"xmap gkn <plug>NERDCommenterNested
	"xmap gkm <plug>NERDCommenterAltDelims
	"xmap gkm <plug>NERDCommenterMinimal
	"xmap gks <plug>NERDCommenterSexy

	nmap gk9 <plug>NERDCommenterToEOL
	nmap gka <plug>NERDCommenterAppend
