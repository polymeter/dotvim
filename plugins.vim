" Use vim-plug to manage plugins

" Ugly repetition of code from vimrc, used only on initial setup
if !exists('g:vimdir')
    " Detect platform-specific vim config directory
    if (has('win32') || has('win64')) && &shellcmdflag =~ '/'
        let g:vimdir='~/vimfiles/'
    else
        let g:vimdir='~/.vim/'
    endif
endif

silent! if plug#begin(g:vimdir . 'plugged')

" --- General plugins ---
Plug 'altercation/vim-colors-solarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'

Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/matchit.zip'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

" --- Language-specific plugins ---

" Git
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
