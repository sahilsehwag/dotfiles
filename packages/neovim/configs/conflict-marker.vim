let g:conflict_marker_enable_mappings = 0
let g:conflict_marker_enable_matchit = 1
let g:conflict_marker_enable_highlight = 1

highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81

nnoremap <silent> <Leader>gcn :ConflictMarkerNone<CR>
nnoremap <silent> <Leader>gcb :ConflictMarkerBoth<CR>
nnoremap <silent> <Leader>gcB :ConflictMarkerBoth!<CR>
nnoremap <silent> <Leader>gco :ConflictMarkerOurselves<CR>
nnoremap <silent> <Leader>gct :ConflictMarkerThemselves<CR>
nmap <silent> [x :ConflictMarkerPrevHunk<CR>
nmap <silent> ]x :ConflictMarkerNextHunk<CR>
