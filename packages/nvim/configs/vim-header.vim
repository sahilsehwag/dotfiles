let g:header_auto_add_header = 0
let g:header_alignment = 1
let g:header_field_filename = 0
let g:header_field_modified_by = 0
let g:header_field_author = 'Sahil Sehwag'
let g:header_field_author_email = 'sehwagsahil002@gmail.com'

nmap <silent> <Leader>zh  :AddHeader<CR>
nmap <silent> <Leader>zH  :AddMinHeader<CR>
nmap <silent> <Leader>zlm :AddMITLicense<CR>
nmap <silent> <Leader>zla :AddApacheLicense<CR>
nmap <silent> <Leader>zlg :AddGNULicense<CR>
