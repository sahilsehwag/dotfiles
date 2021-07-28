"CONFIGURATION
	let g:EasyMotion_do_mapping			= 0
	let g:EasyMotion_smartcase			= 1
	let g:EasyMotion_use_upper			= 0
	let g:EasyMotion_enter_jump_first = 1
	let g:EasyMotion_space_jump_first = 1
	"nmap <Leader>j <Plug>(easymotion-prefix)
	"let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
	"hi link EasyMotionTarget Search
"MAPPINGS
	"LEVEL=1
		"MODE:NORMAL
			nmap <Leader>jw <Plug>(easymotion-overwin-w)
			nmap <Leader>jl <Plug>(easymotion-overwin-line)
			nmap <Leader>je <Plug>(easymotion-bd-e)
			nmap <Leader>jf <Plug>(easymotion-overwin-f)
			nmap <Leader>js <Plug>(easymotion-overwin-f2)
			nmap <Leader>jj <Plug>(easymotion-j)
			nmap <Leader>jk <Plug>(easymotion-k)
			nmap <Leader>jJ <Plug>(easymotion-eol-j)
			nmap <Leader>jK <Plug>(easymotion-eol-k)
			nmap <Leader>j. <Plug>(easymotion-repeat)
			nmap <Leader>ja <Plug>(easymotion-jumptoanywhere)
			nmap <Leader>j/ <Plug>(easymotion-sn)
			nmap <Leader>j? <Plug>(easymotion-tn)
		"MODE:OPERATOR
			"omap <Leader>w <Plug>(easymotion-bd-w)
			"omap <Leader>W <Plug>(easymotion-bd-W)
			"omap <Leader>e <Plug>(easymotion-bd-e)
			"omap <Leader>E <Plug>(easymotion-bd-E)
			"omap <Leader>l <Plug>(easymotion-bd-jk)
			"omap <Leader>j <Plug>(easymotion-j)
			"omap <Leader>k <Plug>(easymotion-k)
			"omap <Leader>J <Plug>(easymotion-eol-j)
			"omap <Leader>K <Plug>(easymotion-eol-K)
			"omap <Leader>f <Plug>(easymotion-bd-f)
			"omap <Leader>s <Plug>(easymotion-bd-f2)
			"omap <Leader>t <Plug>(easymotion-bd-t)
			"omap <Leader>S <Plug>(easymotion-bd-t2)
			"omap <Leader>/ <Plug>(easymotion-sn)
			"omap <Leader>? <Plug>(easymotion-tn)
			"omap <Leader>n <Plug>(easymotion-bd-n)
			"omap <Leader>. <Plug>(easymotion-repeat)
			"omap <Leader>v <Plug>(easymotion-segments-LF)
			"omap <Leader>V <Plug>(easymotion-segments-LB)
			"omap <Leader>gv <Plug>(easymotion-segments-RF)
			"omap <Leader>gV <Plug>(easymotion-segments-RB)
			"omap <Leader>a <Plug>(easymotion-jumptoanywhere)
		"MODE:VISUAL
			xmap <Leader>w <Plug>(easymotion-bd-w)
			xmap <Leader>W <Plug>(easymotion-bd-W)
			xmap <Leader>e <Plug>(easymotion-bd-e)
			xmap <Leader>E <Plug>(easymotion-bd-E)
			xmap <Leader>l <Plug>(easymotion-bd-jk)
			xmap <Leader>j <Plug>(easymotion-j)
			xmap <Leader>k <Plug>(easymotion-k)
			xmap <Leader>J <Plug>(easymotion-eol-j)
			xmap <Leader>K <Plug>(easymotion-eol-K)
			xmap <Leader>f <Plug>(easymotion-bd-f)
			xmap <Leader>t <Plug>(easymotion-bd-t)
			xmap <Leader>s <Plug>(easymotion-bd-f2)
			xmap <Leader>S <Plug>(easymotion-bd-t2)
			xmap <Leader>/ <Plug>(easymotion-sn)
			xmap <Leader>? <Plug>(easymotion-tn)
			xmap <Leader>n <Plug>(easymotion-bd-n)
			xmap <Leader>. <Plug>(easymotion-repeat)
			xmap <Leader>v <Plug>(easymotion-segments-LF)
			xmap <Leader>V <Plug>(easymotion-segments-LB)
			xmap <Leader>gv <Plug>(easymotion-segments-RF)
			xmap <Leader>gV <Plug>(easymotion-segments-RB)
			xmap <Leader>a <Plug>(easymotion-jumptoanywhere)
	"LEVEL=2
	"LEVEL=3
