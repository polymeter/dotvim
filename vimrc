" Detect platform-specific vim config directory
if (has('win32') || has('win64')) && &shellcmdflag =~ '/'
    let g:vimdir='~/vimfiles/'
else
    let g:vimdir='~/.vim/'
endif

" Load plugins
let s:pluginfile = expand(g:vimdir . 'plugins.vim')
if filereadable(s:pluginfile)
    execute 'source' s:pluginfile
endif

" General options
" ---------------

set nocompatible

filetype plugin indent on
syntax on

" Don't use latin1 (taken from tpope's vim-sensible)
if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

set fileencodings=utf-8,latin1
set fileformats=unix,dos

" Cursor movement
set autoindent
set backspace=indent,eol,start
set scrolloff=5                 " Keep lines visible at top and bottom
set sidescrolloff=5             " Keep lines visible at the sides
set smarttab

" Display options
set breakindent                 " Indent wrapped lines
set display=lastline            " Do partly display last line in window
set fillchars=""                " No characters in window separators
set lazyredraw                  " No redraw during macros
set linebreak                   " Don't break inside words
set list                        " Highlight listchars (see below)
set number                      " Enable line numbering
set ruler                       " Display line and column numbers
let &showbreak = "\u2192\ "     " Show arrow symbol for indented wrapped lines
set showcmd                     " Show command in status line
set showmatch                   " Highlight matching brackets

" Special characters for highlighting tabs, trailing spaces etc.
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
    let &listchars = "tab:\u203a\ ,trail:\u2022,extends:\u21c9,precedes:\u21c7,nbsp:\u2423"
else
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif

" Basic editing
set cpoptions+=$            " Mark editing area with c<motion>
set expandtab               " Always use spaces
set formatoptions+=tcqrj    " Auto-wrap text and comments, format comments with "gq"
                            " insert comment leader on newline and remove on join
set pastetoggle=<F12>
set shiftround              " Indent only in multiples of shiftwidth
set shiftwidth=4            " Indentation step size
set softtabstop=4           " <Tab> presses etc. count for 4 spaces
set tabstop=4               " A real tab counts for four spaces

" File management and temporary files
set autoread        " Automatically read files when changed on disk
set autowrite       " Automatically write files on buffer change etc.
set history=1000
set noswapfile

" Folding
set foldlevelstart=99   " Generally start with all folds open

" Searching
set hlsearch    " Highlight search patterns
set ignorecase
set incsearch   " Show matches while typing
set smartcase   " Override 'ignorecase' when pattern contains uppercase

" Statusline
set laststatus=2
set statusline=[%n]\                    " Buffer number
set statusline+=%<%f\                   " Filename
set statusline+=%m%w%h%r                " Modified/preview/help/ro flags
set statusline+=\ %y[%{&ff}]            " File type and line-endings
set statusline+=%=%-14.(%l,%c%V%)\ %P   " Right-aligned nav info

" Wildmenu
set wildmenu                    " Enable wildmenu command completion
set wildmode=list:longest,full  " Tab-complete longest common part, then all
set wildignore+=*.egg-info/*,*/__pycache__/*,*.aux

" Window management
set splitbelow  " Open split windows below current
set splitright  " Open vsplit windows right of current

" Windows stuff
set shellslash      " Use forward slashes even on windows
set winaltkeys=no

" GUI settings
if has('gui_running')
    set guioptions=""   " Disable menus in gvim
    if has('win32') || has('win64')
        set guifont=Consolas:h10,Courier\ New:h10
    endif
endif

" Colors
set background=dark

" Solarized is used as a plugin, so only attempt to set if plugins are loaded.
if exists('g:plugins_loaded')
    colorscheme solarized
    call togglebg#map("<F11>") " solarized-specific function
endif

" Allow color schemes to do bright colors without forcing bold.
" (taken from tpope's vim-sensible)
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

" Mappings etc.
" -------------

let mapleader=","

" Commands
" --------

" Strip trailing whitespace on save
autocmd BufWritePre * call StripTrailingWhitespace()
function! StripTrailingWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
