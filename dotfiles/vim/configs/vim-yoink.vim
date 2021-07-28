let g:yoinkMaxItems					 = 10
let g:yoinkSyncNumberedRegisters	 = 1
let g:yoinkIncludeDeleteOperations = 1
let g:yoinkAutoFormatPaste			 = 0
let g:yoinkIncludeNamedRegisters	 = 0

nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)
nmap <expr> p yoink#canSwap() ? '<plug>(YoinkPostPasteSwapBack)' : '<plug>(YoinkPaste_p)'
nmap <expr> P yoink#canSwap() ? '<plug>(YoinkPostPasteSwapForward)' : '<plug>(YoinkPaste_P)'
