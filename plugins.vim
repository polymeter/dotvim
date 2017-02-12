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

Plug 'altercation/vim-colors-solarized'

" Energize!
call plug#end()

let g:plugins_loaded = 1
endif
