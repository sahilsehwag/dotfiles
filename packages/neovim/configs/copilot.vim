let g:copilot_no_maps = v:true
let g:copilot_no_tab_map = v:true

imap <silent><script><nowait><expr> <C-E>   copilot#Accept("\<C-E>")
imap <silent><script><nowait><expr> <C-Esc> copilot#Dismiss()
imap <silent><script><nowait><expr> <C-9>   copilot#Previous()
imap <silent><script><nowait><expr> <C-0>   copilot#Next()
