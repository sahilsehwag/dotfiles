let g:bullets_checkbox_markers						= ' ·○●✕'
let g:bullets_checkbox_partials_toggle		= 1
let g:bullets_delete_last_bullet_if_empty = 1
let g:bullets_enable_in_empty_buffers			= 1
"let g:bullets_enabled_file_types					= ['*']
let g:bullets_enabled_file_types					= ['text', 'scratch', '']
let g:bullets_line_spacing								= 1
let g:bullets_max_alpha_characters				= 2
let g:bullets_nested_checkboxes						= 1
let g:bullets_pad_right										= 1
let g:bullets_renumber_on_change					= 1
let g:bullets_set_mappings								= 1

let g:bullets_outline_levels = ['ROM', 'ABC', 'num', 'abc', 'rom', 'std-', 'std*', 'std+']

inoremap <silent><buffer> <CR> :InsertNewBullet<CR>

nnoremap <silent><buffer> << :BulletDemote<CR>
vnoremap <silent><buffer> << :BulletDemoteVisual<CR>
nnoremap <silent><buffer> >> :BulletPromote<CR>
vnoremap <silent><buffer> >> :BulletPromoteVisual<CR>

nnoremap <silent><buffer> ,vt :SelectBulletText<CR>
nnoremap <silent><buffer> ,vb :SelectBullet<CR>

nnoremap <silent><buffer> <LocalLeader>c :SelectCheckbox<CR>
nnoremap <silent><buffer> <LocalLeader>C :SelectCheckboxInside<CR>
nnoremap <silent><buffer> <LocalLeader>t :ToggleCheckbox<CR>

vnoremap <silent><buffer> <LocalLeader>r :RenumberSelection<CR>
nnoremap <silent><buffer> <LocalLeader>r :RenumberList<CR>
