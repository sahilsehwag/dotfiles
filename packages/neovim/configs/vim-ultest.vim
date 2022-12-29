let g:ultest_use_pty = 1

let g:ultest_summary_width = 125

let g:ultest_show_in_file = 1
let g:ultest_virtual_text = 0
"let g:ultest_pass_text = ''
"let g:ultest_fail_text = ''
"let g:ultest_running_text = ''
"let g:ultest_summary_open = 'call nvim_open_win(nvim_get_current_buf(), 1, { "relative" : "editor", "row" : &lines * 0.1, "col": &columns * 0.1, "height": float2nr(round(&lines * 0.8)), "width": float2nr(round(&columns * 0.8)), "border": "rounded" })'

let g:ultest_pass_sign = ''
let g:ultest_fail_sign = ''
let g:ultest_running_sign = ''
let g:ultest_not_run_sign = ''

let g:ultest_summary_mappings = {
	\'run': 'r',
	\'stop': 's',
	\'output': 'o',
	\'jumpto': '<CR>',
	\'attach': 'a',
	\'next_fail': ']f',
	\'prev_fail': '[f',
\}

nnoremap <Leader>lt. <CMD>UltestSummary!<CR>
nnoremap <Leader>ltt <CMD>Ultest<CR>
nnoremap <Leader>ltf <CMD>Ultest<CR>
nnoremap <Leader>ltn <CMD>UltestNearest<CR>
nnoremap <Leader>ltl <CMD>UltestLast<CR>
nnoremap <Leader>lts <CMD>UltestStop<CR>
nnoremap <Leader>ltc <CMD>UltestClear<CR>
nnoremap <Leader>lto <CMD>UltestOutput<CR>
nnoremap <Leader>lta <CMD>UltestAttach<CR>

nmap [t <Plug>(ultest-prev-fail)
nmap ]t <Plug>(ultest-next-fail)

hi UltestPass ctermfg=Green guifg=#96F291
hi UltestFail ctermfg=Red guifg=#F70067
hi UltestRunning ctermfg=Yellow guifg=#FFEC63
hi UltestBorder ctermfg=Red guifg=#F70067
hi UltestSummaryInfo ctermfg=cyan guifg=#00F1F5 gui=bold cterm=bold
hi link UltestSummaryFile UltestSummaryInfo
hi link UltestSummaryNamespace UltestSummaryInfo
