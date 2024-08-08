#!/usr/bin/env bash 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "$SCRIPT_DIR"


d=$(date +%H_%I_%m-%Y%m%d)
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

ln -sfn "${SCRIPT_DIR}"/pd.vimrc-base ~/pd.vimrc-base
ln -sfn "${SCRIPT_DIR}" ~/.vim
ln -sfn "${SCRIPT_DIR}"/pd.vimrc-noplugin ~/.vimrc-noplugin

if [ -n "${MSYSTEM}" ]; then
    echo "MSYS Platform"
	export MSYS=winsymlinks:nativestrict
	ln -sfn "${SCRIPT_DIR}"/pd.vimrc-noplugin ~/.vimrc
    #msys2
    if [ -x "$(command -v pacman)" ]; then 
        pacman -Syu --noconfirm
        pacman -S --noconfirm vim mingw-w64-ucrt-x86_64-ripgrep mingw-w64-ucrt-x86_64-universal-ctags 
    fi
	exit 0
fi