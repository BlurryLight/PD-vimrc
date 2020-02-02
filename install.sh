#!/bin/bash 
# ubuntu
ln -sf `pwd`/pd.vimrc ~/.vimrc
ln -sf `pwd` ~/.vim
mkdir -p ~/.vim/template
echo "#!/usr/bin/env python\n#encoding: utf-8\n" > ~/.vim/template/python.tpl
sudo apt install build-essential cmake python3-dev
sudo apt install silversearcher-ag
sudo apt install ctags gtags
