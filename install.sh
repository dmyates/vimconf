#!/bin/bash
ln -s $PWD/.vimrc $HOME/.vimrc
ln -s $PWD/.vim $HOME/.vim

# install Vundle
mkdir .vim/bundle
cd .vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git
