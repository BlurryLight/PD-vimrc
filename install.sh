#!/bin/bash 

cp ~/.vimrc ~/.vimrcbak
ln -sf `pwd`/pd.vimrc-youcompleteme ~/.vimrc
ln -sf `pwd`/pd.vimrc-base ~/pd.vimrc-base
ln -sf `pwd`/globalrc ~/.globalrc
ln -sf `pwd`/.ideavimrc ~/.ideavimrc
ln -sf `pwd` ~/.vim
# sudo apt install build-essential cmake python3-dev
# sudo apt install silversearcher-ag
# sudo apt install ctags gtags
