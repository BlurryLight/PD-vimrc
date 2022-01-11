#!/bin/bash 

if [ -e ~/.vimrc ]
    then cp ~/.vimrc ~/.vimrcpdbak
 echo "Original .vimrc has been renamed to .vimrcpdbak"
fi

ln -sf `pwd`/pd.vimrc-youcompleteme ~/.vimrc
ln -sf `pwd`/pd.vimrc-base ~/pd.vimrc-base
ln -sf `pwd`/globalrc ~/.globalrc
ln -sf `pwd`/.ideavimrc ~/.ideavimrc
ln -sf `pwd` ~/.vim
ln -sf `pwd`/tmux.conf ~/.tmux.conf

echo "Run vim +PlugInstall"
# sudo apt install build-essential cmake python3-dev
# sudo apt install silversearcher-ag ripgrep fzf
# sudo apt install universal-ctags global
