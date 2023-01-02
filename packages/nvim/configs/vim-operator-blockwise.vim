nmap yb <Plug>(operator-blockwise-yank-head)
nmap db <Plug>(operator-blockwise-delete-head)
nmap cb <Plug>(operator-blockwise-change-head)

"EXAMPLE
"nmap gub operator#blockwise#mapexpr('gu')
"nmap gub operator#blockwise#mapexpr_head('gu')
"nmap gub operator#blockwise#mapexpr_tail('gu')

nmap <expr> gub operator#blockwise#mapexpr('gu')
nmap <expr> gUb operator#blockwise#mapexpr('gU')

"FIX: not-working
"nmap <expr> ysb operator#blockwise#mapexpr('ys')
"nmap <expr> dsb operator#blockwise#mapexpr('ds')
"nmap <expr> csb operator#blockwise#mapexpr('cs')

nmap <expr> gyb operator#blockwise#mapexpr('gy')
nmap <expr> ghb operator#blockwise#mapexpr('gh')
