set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()

"PACKAGE MANAGERS
Plugin 'VundleVim/Vundle.vim'
"Plugin 'tpope/vim-pathogen'


"DEVELOPMENT & PROGRAMMING
Plugin 'tpope/vim-fugitive'
Plugin 'vifm/vifm.vim'
"Plugin 'vifm/neovim-vifm'
"Plugin 'syntastic'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/vim-easy-align'
Plugin 'godlygeek/tabular'
Plugin 'mattn/emmet-vim'
"Plugin 'SirVer/ultisnips'
"Plugin 'Conque-Shell'
"Plugin 'Shougo/vimshell.vim'
"Plugin 'Shougo/vimproc.vim'
"Plugin 'khzaw/vim-conceal'
Plugin 'rking/ag.vim'
Plugin 'mileszs/ack.vim'
Plugin 'rhysd/devdocs.vim'

"MOTION & NAVIGATION
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'taiansu/nerdtree-ag'
"Plugin 'troydm/easytree.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'sgur/ctrlp-extensions.vim'
Plugin 'tacahiroy/ctrlp-funky'
"Plugin 'd11wtq/ctrlp_bdelete.vim'
Plugin 'fisadev/vim-ctrlp-cmdpalette'
Plugin 'DavidEGx/ctrlp-smarttabs'
Plugin 'mattn/ctrlp-launcher'
Plugin 'mattn/ctrlp-register'
Plugin 'mattn/ctrlp-mark'
"Plugin 'lokikl/vim-ctrlp-ag'
"Plugin 'mattn/ctrlp-ghq'
"Plugin 'amiorin/ctrlp-z'
Plugin 'pasela/ctrlp-cdnjs'
"Plugin 'mattn/ctrlp-google'
"Plugin 'christoomey/ctrlp-generic'
"Plugin 'nmanandhar/vim-ctrlp-menu'
"Plugin 'tracyone/ctrlp-leader-guide'
Plugin 'ompugao/ctrlp-history'
"Plugin 'mattn/ctrlp-windowselector'
"Plugin 'ompugao/ctrlp-locate'
"Plugin 'voronkovich/ctrlp-nerdtree.vim'
"Plugin 'imkmf/ctrlp-branches'
Plugin 'zeero/vim-ctrlp-help'
Plugin 'endel/ctrlp-filetype.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'joequery/Stupid-EasyMotion'
Plugin 'goldfeld/vim-seek'

"COMMANDS
Plugin 'wellle/targets.vim'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-titlecase'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-expand-region'
Plugin 'vim-indent-object'
Plugin 'kana/vim-textobj-line'
Plugin 'thinca/vim-textobj-comment'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-unimpaired'
"Plugin 'h1mesuke/textobj-wiw'
Plugin 'junegunn/vim-after-object'
"Plugin 'rhysd/vim-textobj-anyblock'    #DOESN'T WORKS PROPERLY
Plugin 'kana/vim-textobj-entire'
"Plugin 'bkad/CamelCaseMotion'
Plugin 'chaoren/vim-wordmotion'
Plugin 'coderifous/textobj-word-column.vim'

"EXTENDING VIM
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'
Plugin 'haya14busa/vim-asterisk'
"Plugin 'tmhedberg/matchit'
Plugin 'auto-pairs'
Plugin 'rhysd/clever-f.vim'
Plugin 'gorodinskiy/vim-coloresque'
"Plugin 'kana/vim-submode'
Plugin 'visualrepeat'
Plugin 'haya14busa/vim-over'
"Plugin 'vim-scripts/restart.vim'
Plugin 'sjl/gundo.vim'
"Plugin 'severin-lemaignan/vim-minimap'
Plugin 'junegunn/limelight.vim'
Plugin 'tpope/vim-capslock'
Plugin 'pseewald/vim-anyfold'
Plugin 'arecarn/vim-fold-cycle'
"Plugin 'ervandew/supertab'
Plugin 'inside/vim-search-pulse'
"Plugin 'ivyl/vim-bling'
"Plugin 'haya14busa/vim-operator-flashy'
"Plugin 'gioele/vim-autoswap'
"Plugin '907th/vim-auto-save'


"PROGRAMMING
Plugin 'argtextobj.vim'
"Plugin 'AndrewRadev/switch.vim'

"MISCELLANOUS
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-operator-user'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
Plugin 'jceb/vim-orgmode'
"Plugin 'LanguageTool'		 					"DOWNLOAD AT http://www.languagetool.org/
Plugin 'dhruvasagar/vim-table-mode'
"Plugin 'DrawIt'
Plugin 'shime/vim-livedown'
"Plugin 'suan/vim-instant-markdown'
Plugin 'duggiefresh/vim-easydir'
Plugin 'aaronbieber/vim-quicktask'
Plugin 'itchyny/calendar.vim'
Plugin 'mattn/webapi-vim'
Plugin 'tyru/open-browser.vim'
"Plugin 'junegunn/vim-emoji'
"Plugin 'ktonga/vim-follow-my-lead'
"Plugin 'reedes/vim-wheel'
Plugin 'vim-scripts/searchfold.vim'
Plugin 'gioele/vim-veryvisual'

"EDITOR RELATED
Plugin 'mhinz/vim-startify'
Plugin 'numbers.vim'
Plugin 'vim-signature'
Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'tpope/vim-repeat'
Plugin 'szw/vim-maximizer'
"Plugin 'Yggdroot/indentLine'
Plugin 'wikitopian/hardmode'
Plugin 'joeytwiddle/sexy_scroller.vim'
Plugin 'xolox/vim-session'
Plugin 'okcompute/vim-ctrlp-session'
Plugin 'mkitt/tabline.vim'
"Plugin 'gcmt/taboo.vim'
"Plugin 'thinca/vim-fontzoom'
"Plugin 'millermedeiros/vim-statline'
Plugin 'junegunn/goyo.vim'
Plugin 'bilalq/lite-dfm'
Plugin 'mikewest/vimroom'

"LOOK & FEEL
Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'
Plugin 'Reewr/vim-monokai-phoenix'
Plugin 'ryanoasis/vim-devicons'
Plugin 'ScrollColors'
"Plugin 'augustold/vim-airline-colornum'

"SYNTAX & LANGUAGE
Plugin 'plasticboy/vim-markdown'
Plugin 'othree/html5.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'groenewege/vim-less'
Plugin 'digitaltoad/vim-pug'
Plugin 'derekwyatt/vim-scala'
Plugin 'wavded/vim-stylus'

"TOTRY
"Plugin 't9md/vim-smalls'
"Plugin 'machakann/vim-sandwich'
"Plugin 'rhysd/vim-operator-surround'
"Plugin 'svermeulen/vim-extended-ft'
"Plugin 'dahu/vim-fanfingtastic'
"Plugin 'chrisbra/improvedft'
"Plugin 'justinmk/vim-sneak'
"Plugin 'kana/vim-smartword'
"Plugin 'tommcdo/vim-lion'
"Plugin 'dyng/ctrlsf.vim'
"Plugin 'nixprime/cpsm'
"Plugin 'Chun-Yang/vim-action-ag'
"Plugin 'skwp/yankring.vim'
"Plugin 'francoiscabrol/ranger.vim'
"Plugin 'mjbrownie/swapit'
"Plugin 'embear/vim-foldsearch'
"Plugin 'ivalkeen/vim-ctrlp-tjump'
"Plugin 'haya14busa/vim-easyoperator-line'
"Plugin 'haya14busa/vim-easyoperator-phrase'
"Plugin 'vim-ctrlspace/vim-ctrlspace'
"Plugin 'amiorin/vim-fasd'
"Plugin 'rgrinberg/vim-operator-gsearch'

call vundle#end()
filetype plugin indent on


"PREFERENCES
set number
set relativenumber
set autoindent
"set smartindent
"set expandtab
set shiftwidth=4
set hls
set incsearch
set ignorecase
set smartcase
set tabstop=4
set showcmd
set cursorline
set paste
set hidden
"set iskeyword+="@,32,34,39,40-41,44-58,60-62,91-93,95-96,123-125,128-167,224-235"
"set cursorcolumn
"set foldmethod=indent
"set spell
"set foldopen=search,undo,mark,tag,quickfix,block,percent,hor
"set foldclose=all
colorscheme Monokai

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=b 
set guioptions+=a

syntax on
filetype on
filetype plugin on
filetype indent on

"autocmd BufEnter * silent! lcd %:p:h


"KEY MAPPINGS
let mapleader = " "
nmap <SPACE> <LEADER>

"REMAPPINGS
nnoremap <A-UP> <C-a>
nnoremap <A-DOWN> <C-x>

"TAB MAPPINGS
nnoremap <C-n> :tabnew<CR>
nnoremap <C-x> :tabclose<CR>
nnoremap <C-LEFT> :tabprevious<CR>
nnoremap <C-RIGHT> :tabnext<CR>
nnoremap <C-DOWN> :tabmove -<CR>
nnoremap <C-UP> :tabmove +<CR>

nnoremap <LEADER>ta :tabnew<CR>
nnoremap <LEADER>td :tabclose<CR>
nnoremap <LEADER>tp :tabprevious<CR>
nnoremap <LEADER>tn :tabnext<CR>
nnoremap <LEADER>tmf :tabmove -<CR>
nnoremap <LEADER>tmb :tabmove +<CR>

nnoremap <LEADER>tb :windo bd<CR>
nnoremap <LEADER>tfb :windo bd!<CR>


"WINDOW MAPPINGS
nnoremap <Leader>wh :sp 
nnoremap <Leader>wv :vsp 
nnoremap <LEADER>wm :MaximizerToggle<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-w> :q<CR>
"nnoremap <C-s> :w<CR>
nnoremap <C-q> :wq<CR>
"nmap <> :w 

"BUFFER MAPPINGS
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>
nnoremap <LEADER>bn :e 
nnoremap <LEADER>ba :badd 
nnoremap <LEADER>bd :bdelete<CR>
nnoremap <LEADER>bfd :bdelete!<CR>

"MISCELLANOUS AND TRADITIONAL MAPPINGS
"nnoremap <LEADER>uy yiw 				"word copying
nnoremap <LEADER>uc viw~				"WORD case toggling
nnoremap <LEADER>uC V~				"LINE case toggling
nnoremap <LEADER>uu viwU				"WORD case toggling
nnoremap <LEADER>uU VU				"LINE case toggling
nnoremap <LEADER>ul viwu				"WORD case toggling
nnoremap <LEADER>uL Vu				"LINE case toggling
nnoremap <LEADER>up :set paste<CR>"*]p:set nopaste<cr>
nnoremap <LEADER>uP :set paste<CR>"*]P:set nopaste<cr>

nnoremap <LEADER>j 10j
nnoremap <LEADER>k 10k

"nnoremap <TAB> i<TAB><ESC>			"imitates TAB
"inoremap <S-TAB> <ESC>^Xi
nnoremap ï o<Esc>				"newline on ENTER
nnoremap <S-ENTER> o<TAB>
inoremap <S-ENTER> <ESC>o<TAB>
nnoremap <C-a> G$vgg				"CTRL+a
"nnoremap <F2> :noh<CR> 

"SEARCH AND REPLACE
"nnoremap <LEADER>r :%s//<LEFT>
"nnoremap <LEADER>rg :%s//g<LEFT><LEFT>
"nnoremap <LEADER>rgc :%s//gc<LEFT><LEFT><LEFT>
"nnoremap <LEADER>rgci :%s//gci<LEFT><LEFT><LEFT><LEFT>
"nnoremap <LEADER>rgcI :%s//gcI<LEFT><LEFT><LEFT><LEFT>
"nnoremap <LEADER>rw :%s/\<\>/g<LEFT><LEFT><LEFT><LEFT>

"nnoremap <LEADER>rl :s//<LEFT>
"nnoremap <LEADER>rlg :s//g<LEFT><LEFT>
"nnoremap <LEADER>rlgc :s//gc<LEFT><LEFT><LEFT>
"nnoremap <LEADER>rlgci :s//gci<LEFT><LEFT><LEFT><LEFT>
"nnoremap <LEADER>rlgcI :s//gcI<LEFT><LEFT><LEFT><LEFT>

"REGISTER MAPPINGS
nnoremap <LEADER>ra "a


"nnoremap <SPACE><SPACE> A

"FILETYPE SPECIFIC MAPPINGS
"autocmd Filetype cpp nnoremap 



"PATHEGON PACKAGE MANAGER
"execute pathogen#infect()



"PACKAGES MAPPING AND CONFIGURATION
"vim-expand
"map K <Plug>(expand_region_expand)
"map J <Plug>(expand_region_shrink)


"vim-easymotion
let g:EasyMotion_smartcase = 1
nmap <LEADER>e <Plug>(easymotion-prefix)
nmap <LEADER>ef <Plug>(easymotion-overwin-f)
nmap <LEADER>es <Plug>(easymotion-overwin-f2)
nmap <LEADER>el <Plug>(easymotion-overwin-line)
nmap <LEADER>ew <Plug>(easymotion-overwin-w)

"vim-stupid-easymotion
"nmap <LEADER><LEADER>w \\w
"nmap <LEADER><LEADER>W \\W
"nmap <LEADER><LEADER>f \\f

"vim-easyoperator-line
"nmap d<LEADER>el <Plug>(easyoperator-line-delete) 
"nmap s<LEADER>el <Plug>(easyoperator-line-select) 
"nmap y<LEADER>el <Plug>(easyoperator-line-yank) 

"vim-titlecase
let g:titlecase_map_keys = 0
nmap <LEADER>ut viw<plug>Titlecase
"vmap <leader>ut <plug>titlecase
nmap <LEADER>uT <Plug>TitlecaseLine


"numbers
nnoremap <F3> :NumbersToggle<CR>
"nnoremap <F4> :NumbersOnOff<CR>


"NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
nnoremap <C-o> :NERDTreeToggle<CR>
nnoremap <C-c> :NERDTree %<CR>
"nnoremap <LEADER>nc :NERDTree %<CR>
"nnoremap <LEADER>nt :NERDTreeToggle<CR>
"nnoremap <LEADER>nb :NERDTree 


"syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_cpp_checkers = ['syntastic-cpp-gcc']

"powerline
set encoding=utf-8
set laststatus=2
"let g:Powerline_symbols = 'fancy'
"set fillchars+=stl:\ ,stlnc:\


"ctrlp
"nnoremap <C-b> :CtrlPBuffer<CR>
nnoremap M :CtrlPMRU<CR>
"nnoremap <C-f> :CtrlPFunky<Cr>
let g:ctrlp_extensions = ['dir', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir', 'smarttabs', 'mark', 'register', 'launcher', 'ghq', 'F', 'Z', 'cdnjs', 'filetype']
"let g:ctrlp_show_hidden = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'
let g:ctrlp_working_path_mode = 'rac'
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_arg_map = 1
"let g:ctrlp_prompt_mappings = { 'ToggleMRURelative()': ['<LEADER>nR'] }
"
"if executable("ag")
	"set grepprg=ag\ --nogroup\ --nocolor
	"let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif

nnoremap <LEADER>np :CtrlP<CR>
nnoremap <LEADER>na :CtrlPMixed<CR>
nnoremap <LEADER>nb :CtrlPBookmark<CR>
nnoremap <LEADER>nbd :CtrlPBookmarkDir<CR>
nnoremap <LEADER>nc :CtrlPCmdPalette<CR>
nnoremap <LEADER>nd :CtrlPDir<CR>
nnoremap <LEADER>nf :CtrlPFunky<CR>
nnoremap <LEADER>nm :CtrlPMenu<CR>
nnoremap <LEADER>nl :CtrlPLauncher<CR>
nnoremap <LEADER>nr :CtrlPMRU<CR>
nnoremap <LEADER>ns :CtrlPSession<CR>
nnoremap <LEADER>nt :CtrlPSmartTabs<CR>


"vim-ctrlp-cmdpallete
let g:ctrlp_cmdpalette_execute = 0

"vim-ctrlp-session
nnoremap <LEADER>sn :Session 
nnoremap <LEADER>sl :SLoad 
nnoremap <LEADER>sd :SDelete 
nnoremap <LEADER>sq :SQuit<CR>
nnoremap <LEADER>sp :CtrlPSession<CR>



"vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'
	"powerlineish 
	"solarized light 
	"solarized dark 
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'


"tagbar
"nnoremap <LEADER>ttb :TagbarToggle<CR>
"let g:tagbar_ctags_bin=""


"indentLine
"let g:indentLine_color_term = 239
"let g:indentLine_color_gui = ''
"let g:indentLine_char = '¦'

"hardmode
nnoremap <leader>th <Esc>:call ToggleHardMode()<CR>
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

"vim-seek
"let g:SeekKey = 'f'
"let g:SeekBackKey = 'F'
"let g:SeekCutShortKey = 't'
"let g:SeekBackCutShortKey = 'T'
let g:seek_enable_jumps = 1

"vim-devicons
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
"set guifont=DroidSansMonoPLNerd:h12
set encoding=utf8
"let g:airline_powerline_fonts = 1
"let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0
"let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol='x'

"vim-maximzer
let g:maximizer_set_default_mapping = 0

"vim-asterik
"map *   <Plug>(asterisk-*)
"map #   <Plug>(asterisk-#)
"map g*  <Plug>(asterisk-g*)
"map g#  <Plug>(asterisk-g#)
"map z*  <Plug>(asterisk-z*)
"map gz* <Plug>(asterisk-gz*)
"map z#  <Plug>(asterisk-z#)
"map gz# <Plug>(asterisk-gz#)

"incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl-n)<Plug>Pulse
map N <Plug>(incsearch-nohl-N)<Plug>Pulse
map * <Plug>(incsearch-nohl-*)<Plug>Pulse
map # <Plug>(incsearch-nohl-#)<Plug>Pulse
map g* <Plug>(incsearch-nohl-g*)<Plug>Pulse
map g# <Plug>(incsearch-nohl-g#)<Plug>Pulse

"incsearch-easymotion
map / <Plug>(incsearch-easymotion-/)
map ? <Plug>(incsearch-easymotion-?)
map g/ <Plug>(incsearch-easymotion-stay)

"incsearch-fuzzy
map <LEADER>fs/ <Plug>(incsearch-fuzzyspell-/)
map <LEADER>fs? <Plug>(incsearch-fuzzyspell-?)
"map <LEADER>fz/ <Plug>(incsearch-fuzzyspell-stay)

map <LEADER>f/ <Plug>(incsearch-fuzzy-/)
map <LEADER>f? <Plug>(incsearch-fuzzy-?)
"map <LEADER>fs <Plug>(incsearch-fuzzy-stay)

"clever-f.vim
let g:clever_f_ignore_case=1
let g:clever_f_smart_case=1
"let g:clever_f_mark_char_color='cssColor66ffcc'

"vim-bookmarks
"let g:bookmark_sign = '§'
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_no_default_key_mappings = 1
"let g:bookmark_save_per_working_dir = 1
nnoremap <LEADER>mb :CtrlPBookmark<CR>
nnoremap <LEADER>mt :BookmarkToggle<CR>
nnoremap <LEADER>ma :BookmarkAnnotate 
nnoremap <LEADER>mn :BookmarkNext<CR>
nnoremap <LEADER>mp :BookmarkPrev<CR>
nnoremap <LEADER>mc :BookmarkClear<CR>
nnoremap <LEADER>mca :BookmarkClearAll<CR>
nnoremap <LEADER>ms :BookmarkSave 
nnoremap <LEADER>ml :BookmarkLoad 
nnoremap <LEADER>mu :BookmarkUp<CR>
nnoremap <LEADER>md :BookmarkDown<CR>

"languageTool
"let g:languagetool_jar="C:/Program Files (x86)/LanguageTool-3.6/languagetool-commandline.jar"

"vim-restart

"vim-session
nnoremap <LEADER>vr :RestartVim<CR>
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_default_name = 'default'
let g:session_default_to_last = 'yes'

"vim-anyfold
let anyfold_activate=1
let anyfold_fold_comments=0
set foldlevel=1

"vim-fold-cycle
let g:fold_cycle_default_mapping = 0 "disable default mappings
nmap <Tab> <Plug>(fold-cycle-open)
nmap <S-Tab> <Plug>(fold-cycle-close)

"vim-search-pulse
let g:vim_search_pulse_mode = 'cursor_line'

"ranger
let g:ranger_map_keys=0

"vim-after-object
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

"ctrlp-z
let g:ctrlp_z_nerdtree = 1

"operator-flashy
"map y <Plug>(operator-flashy)
"nmap Y <Plug>(operator-flashy)$

"vim-airline-colornum
"let g:airline_colornum_reversed = 1

"vim-over
nmap <LEADER>ro :OverCommandLine<CR>

"ScrollColors
nnoremap <LEADER>vt :SCROLLCOLOR<CR>

"vim-autosave
let g:auto_save = 1 
"let g:auto_save_silent = 1 

"textobj-wiw
"let g:textobj_wiw_no_default_key_mappings = 1
"let g:textobj_wiw_default_key_mappings_prefix = "h"

"CamleCaseMotion

"vim-wordmotion
"let g:wordmotion_prefix = ''
"let g:wordmotion_mappings = {
"\ 'w' : '<M-w>',
"\ 'b' : '<M-b>',
"\ 'e' : '<M-e>',
"\ 'ge' : 'g<M-e>',
"\ 'aw' : 'a<M-w>',
"\ 'iw' : 'i<M-w>'
"\ }

"vim-smooth-scroll
"noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 30, 2)<CR>
"noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 30, 2)<CR>
"noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 30, 4)<CR>
"noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 30, 4)<CR>

"sexy-scroller
let g:SexyScoller_ScrollTime = 10
let g:SexyScroller_CursorTime = 5
let g:SexyScroller_MaxTime = 500
let g:SexyScroller_EasingStyle = 1


"FZF
command! FZFo :FZF --no-reverse /mnt/c/Users/sehwa/OneDrive
command! FZFh :FZF --no-reverse ~
nnoremap <LEADER>nn :FZFo<CR>
nnoremap <LEADER>nh :FZFh<CR>


"NETRW CONFIGURAION
"let g:netrw_liststyle = 3
"let g:netrw_banner = 0
"let g:netrw_browse_split = 3
"let g:netrw_winsize = 20
"nnoremap <LEADER>no :Vexplore .<CR>




"LEADER SUB MAPPINGS
"a
"b buffers
"c registers/clipboards
"d
"e easy motion
"f find
"g goto and miscellanous
"h
"i
"j
"k
"l
"m marks and bookmarks
"n navigation (nerdtree + ctrlp)
"o
"p
"q
"r replace
"s session management
"t tabs
"u text manipulation
"v vim operations
"w windows
"x
"y
"z miscellanous
" 


xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)











"MISCELLANOUS VIMSCRIPT CONFIGURATION

"AUTOMATIC RELOADING OF .vimrc
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END


"CUSTOM FOLD FORMAT
"function! NeatFoldText() "{{{2
	"let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
	"let lines_count = v:foldend - v:foldstart + 1
	"let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
	"let foldchar = matchstr(&fillchars, 'fold:\zs.')
	"let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	"let foldtextend = lines_count_text . repeat(foldchar, 8)
	"let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
	"return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
"endfunction
"set foldtext=NeatFoldText()
" }}}2


"AUTOMATIC SETTING UP OF jproperties FOR TEXT FILES
autocmd BufNewFile,BufRead *.txt set syntax=jproperties
"autocmd BufNewFile,BufRead *.txt set filetype=jproperties



"SETTING custom KEYWORDS AND TO STOP OVERRIDING BY OTHER PLUGINS
"autocmd Filetype * setlocal iskeyword="@,32,34,39,40-41,44-58,60-62,91-93,95-96,123-125,128-167,224-235"
