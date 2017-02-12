#!/usr/bin/env sh

if [[ ! -d "$HOME/.vim/plugged" ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -u plugins.vim +PlugInstall +qall
else
    echo "vim config is initialized already."
fi
