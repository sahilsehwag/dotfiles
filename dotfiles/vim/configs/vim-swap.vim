let g:swap_no_default_key_mappings = 1
nmap g<			<Plug>(swap-prev)
nmap g>			<Plug>(swap-next)
nmap <Leader>zs <Plug>(swap-interactive)

onoremap id <Plug>(swap-textobject-i)
onoremap ad <Plug>(swap-textobject-a)
