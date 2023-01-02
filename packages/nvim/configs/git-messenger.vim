"CONFIGURATION
	let g:git_messenger_include_diff        = "none"
	let g:git_messenger_max_popup_width     = 200
	let g:git_messenger_max_popup_height    = 40
	let g:git_messenger_no_default_mappings = v:true
	let g:git_messenger_floating_win_opts = { 'border': 'single' }
	let g:git_messenger_popup_content_margins = v:true
"HIGHLIGHTS
	"hi gitmessengerPopupNormal term=None guifg=#eeeeee guibg=#333333 ctermfg=255 ctermbg=234
	"hi gitmessengerHeader term=None guifg=#88b8f6 ctermfg=111
	"hi gitmessengerHash term=None guifg=#f0eaaa ctermfg=229
	"hi gitmessengerHistory term=None guifg=#fd8489 ctermfg=210
"MAPPINGS
	nmap <silent> <Leader>gCl <Plug>(git-messenger)
	nmap <silent> <Leader>gl <Plug>(git-messenger)
