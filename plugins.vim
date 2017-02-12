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

" Plugins are placed in the 'plugged' directory next to vimrc
silent! if plug#begin(g:vimdir . 'plugged')

" --- General plugins ---
Plug 'altercation/vim-colors-solarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'

Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'

" --- Language-specific plugins ---

" Git
Plug 'tpope/vim-git'

" HTML / CSS
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'

" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/python_match.vim'

" Energize!
call plug#end()

let g:plugins_loaded = 1
endif
