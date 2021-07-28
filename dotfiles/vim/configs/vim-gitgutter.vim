let g:gitgutter_map_keys = 0

let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 0

"let g:gitgutter_diff_relative_to = 'working_tree'
let g:gitgutter_preview_win_floating = 1

nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)

nmap <Leader>ghs <Plug>(GitGutterStageHunk)
nmap <Leader>ghr <Plug>(GitGutterUndoHunk)
nmap <Leader>ghp <Plug>(GitGutterPreviewHunk)

nmap <Leader>ghf :GitGutterFold<CR>

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

"STATUSLINE
function! GitStatus()
	let [a,m,r] = GitGutterGetHunkSummary()
	return printf('+%d ~%d -%d', a, m, r)
endfunction
"set statusline+=%{GitStatus()}

let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '⯅'
let g:gitgutter_sign_removed_above_and_below = '⯈⯇'
let g:gitgutter_sign_modified_removed = '~'

highlight! link GitGutterAdd JatAddFG
highlight! link GitGutterChange JatChangeFG
highlight! link GitGutterDelete JatDeleteFG
highlight! link GitGutterChangeDelete JatChangeDeleteFG

"highlight link GitGutterAddLine JatAddBG
"highlight link GitGutterChangeLine JatChangeBG
"highlight link GitGutterDeleteLine JatDeleteBG
"highlight link GitGutterChangeDeleteLine JatChangeDeleteBG

"highlight link GitGutterAddLineNr JatAddBG
"highlight link GitGutterChangeLineNr JatChangeBG
"highlight link GitGutterDeleteLineNr JatDeleteBG
"highlight link GitGutterChangeDeleteLineNr JatChangeDeleteBG

highlight! link GitGutterAddIntraLine JatAddFG
highlight! link GitGutterChangeIntraLine JatChangeFG
highlight! link GitGutterDeleteIntraLine JatDeleteFG
highlight! link GitGutterChangeDeleteIntraLine JatChangeDeleteFG

