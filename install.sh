#!/usr/bin/env bash 
d=`date +%H_%I_%m-%Y%m%d`
if [ -e ~/.vimrc ]
    then cp ~/.vimrc ~/.vimrcpdbak${d}
 echo "Original .vimrc has been renamed to .vimrcpdbak${d}"
fi

if [ -d ~/.ctags.d ]
    then cp -R ~/.ctags.d/ ~/.ctags.d.bak${d}
    echo "Original .ctags conf has been renamed to ~/.ctags.d.bak${d}"
else
    mkdir -p ~/.ctags.d
fi

ln -sfn `pwd`/global.ctags ~/.ctags.d/global.ctags

ln -sfn `pwd`/pd.vimrc-youcompleteme ~/.vimrc
ln -sfn `pwd`/pd.vimrc-base ~/pd.vimrc-base
ln -sfn `pwd`/globalrc ~/.globalrc
ln -sfn `pwd`/.ideavimrc ~/.ideavimrc
ln -sfn `pwd` ~/.vim
ln -sfn `pwd`/tmux.conf ~/.tmux.conf

echo "Run vim +PlugInstall"
# sudo apt install build-essential cmake python3-dev
# sudo apt install silversearcher-ag ripgrep fzf
# sudo apt install universal-ctags global
