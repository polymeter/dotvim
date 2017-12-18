" Plugins {{{
" Detect platform-specific vim config directory
if (has('win32') || has('win64')) && &shellcmdflag =~ '/'
    let g:vimdir='~/vimfiles/'
else
    let g:vimdir='~/.vim/'
endif

silent! if plug#begin(g:vimdir . 'plugged')

" General plugins
Plug 'altercation/vim-colors-solarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'
Plug 'qpkorr/vim-bufkill'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/matchit.zip'

Plug 'w0rp/ale'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" HTML / CSS
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'

" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'

" LaTeX
Plug 'lervag/vimtex'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'mitsuhiko/vim-python-combined'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/python_match.vim'

call plug#end()
endif

" }}}
" General {{{

" Don't use latin1. No, really.
" (taken from tpope's vim-sensible)
if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

set fileencodings=utf-8,latin1
set fileformats=unix,dos

" Cursor movement
set backspace=indent,eol,start
set scrolloff=5                 " Keep lines visible at top and bottom
set sidescrolloff=5             " Keep columns visible at the sides
set smarttab

" Display options
set breakindent                 " Indent wrapped lines
set display=lastline            " Do partly display last line in window
set fillchars=""                " No characters in window separators
set lazyredraw                  " No redraw during macros
set linebreak                   " Don't break inside words
set list                        " Highlight listchars (see below)
set number                      " Enable line numbering
set relativenumber              " Enable relative numbering by default
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

" }}}
" Colors {{{

colorscheme solarized

" Allow color schemes to do bright colors without forcing bold.
" (taken from tpope's vim-sensible)
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

" }}}
" Mappings {{{

let mapleader=","
let maplocalleader="\\"

" Vertical movement by visual line (do not skip over wraps)
nnoremap j gj
nnoremap k gk

nnoremap <leader>n :setlocal relativenumber!<cr>
nnoremap <leader>/ :nohlsearch<cr>

" }}}
" Plugin config {{{

" Airline
let g:airline_theme='solarized'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'VL',
    \ '' : 'VB',
    \ 's'  : 'S',
    \ 'S'  : 'SL',
    \ '' : 'SB',
    \ }
let g:airline#extensions#ale#enabled = 1

" NERDTree
nnoremap <F2> :NERDTreeToggle<CR>

" ALE
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_fixers = {
    \ 'python': ['isort']
\ }

" LaTeX
let g:tex_flavor = 'latex'
if has('gui_running')
    let g:vimtex_compiler_progname = "gvim"
else
    let g:vimtex_compiler_progname = "vim"
endif
if has('win32') || has('win64')
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif

" Python
let g:jedi#force_py_version = 3

" }}}
" Commands {{{

" Strip trailing whitespace on save
augroup StripTrailWS
    autocmd!
    autocmd BufWritePre * call StripTrailingWhitespace()
    autocmd FileType markdown let b:keepTrailingWhitespace=1
augroup END

function! StripTrailingWhitespace() abort
    if exists('b:keepTrailingWhitespace')
        " Use buffer-local variable to prevent stripping
        return
    endif
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" }}}
" Local vimrc {{{
" Load local machine-specific config, if present
let s:localrcfile = expand(g:vimdir . 'vimrc.local')
if filereadable(s:localrcfile)
    execute 'source' s:localrcfile
endif
" }}}
