"let g:bullets_checkbox_markers						= ' ·○●✕'
let g:bullets_checkbox_markers						= ' ·○●x'
let g:bullets_checkbox_partials_toggle		= 0
let g:bullets_delete_last_bullet_if_empty = 1
let g:bullets_enable_in_empty_buffers			= 1
"let g:bullets_enabled_file_types					= ['*']
let g:bullets_enabled_file_types					= ['text', 'scratch', 'markdown', 'mkdc']
let g:bullets_line_spacing								= 1
let g:bullets_max_alpha_characters				= 2
let g:bullets_nested_checkboxes						= 1
let g:bullets_pad_right										= 1
let g:bullets_renumber_on_change					= 1
let g:bullets_set_mappings								= 0

let g:bullets_outline_levels = ['std*', 'std+', 'std-', 'num', 'ROM', 'ABC', 'abc', 'rom']

"let g:bullets_custom_mappings = [
"  \ ['imap',     '<CR>',      '<Plug>(bullets-newline)'],
"  \ ['inoremap', '<C-CR>',    '<cr>'],
"  \ ['nmap',     'o',         '<Plug>(bullets-newline)'],
"  \ ['vmap',     'gN',        '<Plug>(bullets-renumber)'],
"  \ ['nmap',     'gN',        '<Plug>(bullets-renumber)'],
"  \ ['nmap',     '<leader>x', '<Plug>(bullets-toggle-checkbox)'],
"  \ ['imap',     '<C-t>',     '<Plug>(bullets-demote)'],
"  \ ['nmap',     '>>',        '<Plug>(bullets-demote)'],
"  \ ['vmap',     '>',         '<Plug>(bullets-demote)'],
"  \ ['imap',     '<C-d>',     '<Plug>(bullets-promote)'],
"  \ ['nmap',     '<<',        '<Plug>(bullets-promote)'],
"  \ ['vmap',     '<',         '<Plug>(bullets-promote)'],
"  \ ]

let g:bullets_custom_mappings = [
  \ ['imap',     '<CR>',   '<Plug>(bullets-newline)'],
  \ ['nmap',     'o',      '<Plug>(bullets-newline)'],
  \
  \ ['nmap',     '<LocalLeader>x',  '<Plug>(bullets-toggle-checkbox)'],
  \
  \ ['nmap',     '>>',     '<Plug>(bullets-demote)'],
  \ ['vmap',     '>',      '<Plug>(bullets-demote)'],
  \ ['nmap',     '<<',     '<Plug>(bullets-promote)'],
  \ ['vmap',     '<',      '<Plug>(bullets-promote)'],
\ ]
