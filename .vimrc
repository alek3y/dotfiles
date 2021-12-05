"      _
"  _ _|_|_____ ___ ___
" | | | |     |  _|  _|
"  \_/|_|_|_|_|_| |___|
"
" This is ale's ~/.vimrc

set nocompatible

if has('filetype')
	filetype indent plugin on
endif

if has('syntax')
	syntax on
endif

" Highlight trailing whitespaces
highlight WhiteSpaces ctermbg=red guibg=red
match WhiteSpaces /\s\+$/

" Highlight special characters
set list
set listchars=tab:\┊\ ,extends:»,precedes:«,nbsp:⎵
highlight SpecialKey ctermbg=NONE ctermfg=darkgray

" Remember cursor position
autocmd BufReadPost * if line("'\"") | execute("normal `\"") | endif

set hidden	" Ignore unsaved buffer when opening new files
set confirm
set fileformat=unix
set scrolloff=3

set wildmenu	" Show partial commands in the bottom right of the screen
set laststatus=2
set showcmd
set cmdheight=1
set ruler
set splitright

set number
set autoindent
set ignorecase
set smartcase
set backspace=indent,eol,start
set nostartofline	" Remeber column when moving through lines

"set hlsearch	" Highlight searches
set incsearch

" Use Vim internal visual bell and disable it completely
set visualbell
set t_vb=

" Keep mouse enabled, except for when in Insert mode
if has('mouse')
	set mouse=nvc
endif

" Quickly time out on keycodes
set notimeout ttimeout ttimeoutlen=200

" Use Hard tabs
set shiftwidth=4
set tabstop=4

" Redraw the screen and remove highlighting matches with ^L
nnoremap <C-L> :nohl<CR><C-L>
