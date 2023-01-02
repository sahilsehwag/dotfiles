"EXAMPLE
"inoremap <expr> = smartchr#loop(' = ', ' => ', ' -> ')
"inoremap <expr> = smartchr#one_of(' = ', ' => ', ' -> ')

inoremap <expr> = smartchr#one_of('=', ' => ', ' -> ')

autocmd FileType json,javascript,javascriptreact,typescript,typescriptreact inoremap <buffer><expr> ' smartchr#one_of('"', '`', "'")
