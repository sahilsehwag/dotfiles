"CONFIGURATION
	let g:expand_region_text_objects = {
		\'iw'  :0,
		\'iW'  :0,
		\'i"'  :0,
		\'i''' :0,
		\'i]'  :1,
		\'ib'  :1,
		\'iB'  :1,
		\'il'  :0,
		\'ip'  :0,
		\'ie'  :0,
	\}
	" call expand_region#custom_text_objects({
	"   \ "\/\\n\\n\<CR>": 1, " Motions are supported as well. Here's a search motion that finds a blank line
	"   \ 'a]' :1, " Support nesting of 'around' brackets
	"   \ 'ab' :1, " Support nesting of 'around' parentheses
	"   \ 'aB' :1, " Support nesting of 'around' braces
	"   \ 'ii' :0, " 'inside indent'. Available through https://github.com/kana/vim-textobj-indent
	"   \ 'ai' :0, " 'around indent'. Available through https://github.com/kana/vim-textobj-indent
	"   \ })
"MAPPINGS
	map <C-=> <Plug>(expand_region_expand)
	map <C-+> <Plug>(expand_region_shrink)
