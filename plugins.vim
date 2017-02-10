" Use vim-plug to manage plugins

" Plugins are placed in the 'plugged' directory next to vimrc
silent! if plug#begin(g:vimdir . 'plugged')


" Energize!
call plug#end()

let g:plugins_loaded = 1
endif
