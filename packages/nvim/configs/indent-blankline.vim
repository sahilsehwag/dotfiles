let g:indent_blankline_enabled = v:true

let g:indent_blankline_char = '│'
let g:indent_blankline_char_list = []
"let g:indent_blankline_char_highlight = 'SpecialKey'
let g:indent_blankline_char_highlight = 'NonText'
let g:indent_blankline_char_highlight_list = []

let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_indent_level = 10

let g:indent_blankline_filetype = ['html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'python', 'lua', 'vim']
let g:indent_blankline_filetype_exclude = ['help', 'startify', 'floaterm']
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_bufname_exclude = ['README.md', '.*\.py']

let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_context_highlight = ['class', 'function', 'method']
"let g:indent_blankline_context_highlight = 'ModeMsg'
let g:indent_blankline_context_highlight = 'SpecialKey'
