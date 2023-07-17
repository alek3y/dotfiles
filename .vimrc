"      _
"  _ _|_|_____ ___ ___
" | | | |     |  _|  _|
"  \_/|_|_|_|_|_| |___|
"
" This is ale's ~/.vimrc

set nocompatible
filetype plugin indent on

" Clear the search highlighting and redraw the screen
nnoremap <C-L> :nohl<CR><C-L>

" Show trailing whitespaces
autocmd ColorScheme * highlight WhiteSpaces ctermbg=red guibg=#cc6666
autocmd InsertEnter,InsertLeave,BufWinEnter * match WhiteSpaces /\s\+$/

" Appearance
syntax on
"set colorcolumn=86

if &t_Co >= 256
	set termguicolors
endif
"colorscheme desert
"colorscheme zaibatsu
"colorscheme habamax
colorscheme sorbet

" Show tabs
set list
set listchars=tab:\┊\ ,extends:»,precedes:«,nbsp:⎵

" Save cursor
autocmd BufReadPost * if line("'\"") | execute("normal `\"zz") | endif

" Indentation
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0

" Behaviour
set hidden
set confirm
set fileformat=unix
set backspace=indent,eol,start
set nostartofline

if has('mouse')
	set mouse=nvc
endif

" Visual settings
set number
set scrolloff=3
set splitright
set splitbelow
"set virtualedit=onemore

" Statusline
set wildmenu
set showcmd
set cmdheight=1
set laststatus=2
set ruler

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Spell checker
set spelllang=it,en

" Keys timeout
set notimeout ttimeout ttimeoutlen=200

" Bell
set visualbell
set t_vb=
