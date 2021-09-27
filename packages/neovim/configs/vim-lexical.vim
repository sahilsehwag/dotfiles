let g:lexical#spell = 1
let g:lexical#spell_key = '<leader>zs'
let g:lexical#spelllang = ['en_us', 'en_ca',]
"let g:lexical#dictionary = ['/usr/share/dict/words',]
let g:lexical#thesaurus = ['~/.config/nvim/spell/mthesaurus.txt/',]
let g:lexical#spellfile = ['~/.config/spell/en.utf-8.add',]

nnoremap <silent> <Leader><Leader>s :set spell!<CR>
