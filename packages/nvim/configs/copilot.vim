" NOTE: On Neovim nightly (0.11+), the LSP RPC parser became stricter and
" requires CRLF (\r\n) line endings in LSP message headers. The copilot
" language server (shipped inside copilot.vim) sends bare LF (\n) before
" Content-Length, causing spurious INVALID_SERVER_MESSAGE errors in the log.
" This is cosmetic noise — Copilot still works. The upstream fix is in the
" copilot language server binary; run :PlugUpdate copilot.vim to get the
" version that ships a patched agent (1.60+ should resolve it).
" Tracked upstream: https://github.com/github/copilot.vim/issues
let g:copilot_no_maps = v:true
let g:copilot_no_tab_map = v:true

imap <silent><script><nowait><expr> <C-E>   copilot#Accept("\<C-E>")
imap <silent><script><nowait><expr> <C-Esc> copilot#Dismiss()
imap <silent><script><nowait><expr> <C-9>   copilot#Previous()
imap <silent><script><nowait><expr> <C-0>   copilot#Next()
