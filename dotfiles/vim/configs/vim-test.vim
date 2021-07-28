let test#strategy = 'neovim'

nnoremap <Leader>lt. :TestVisit<CR>
nnoremap <Leader>ltf :TestFile<CR>
nnoremap <Leader>lts :TestSuite<CR>
nnoremap <Leader>ltn :TestNearest<CR>
nnoremap <Leader>ltl :TestLast<CR>

let test#javascript#runner = 'jest'
let test#javascript#jest#options = "--color=always"
let test#javascript#reactscripts#options = "--watchAll=false"

let test#typescript#jest#options = "--color=always"

let test#python#pytest#options = "--color=yes"

