#!/usr/bin/env bash 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo $SCRIPT_DIR


d=`date +%H_%I_%m-%Y%m%d`
if [ -e ~/.vimrc ]
    then cp ~/.vimrc ~/.vimrcpdbak${d}
    echo "Original .vimrc has been renamed to .vimrcpdbak${d}"
fi

# MSYS part

if [ -n "${MSYSTEM}" ]; then
    echo "MSYS Platform"
	export MSYS=winsymlinks:nativestrict
	ln -sfn ${SCRIPT_DIR} ~/.vim
	ln -sfn ${SCRIPT_DIR}/pd.vimrc-base ~/pd.vimrc-base
	ln -sfn ${SCRIPT_DIR}/pd.vimrc-noplugin ~/.vimrc
	exit 0
fi

if [ -d ~/.ctags.d ]
    then cp -R ~/.ctags.d/ ~/.ctags.d.bak${d}
    echo "Original .ctags conf has been renamed to ~/.ctags.d.bak${d}"
else
    mkdir -p ~/.ctags.d
fi

ln -sfn ${SCRIPT_DIR}/global.ctags ~/.ctags.d/global.ctags
ln -sfn ${SCRIPT_DIR}/pd.vimrc-youcompleteme ~/.vimrc
ln -sfn ${SCRIPT_DIR}/pd.vimrc-base ~/pd.vimrc-base
ln -sfn ${SCRIPT_DIR}/globalrc ~/.globalrc
ln -sfn ${SCRIPT_DIR}/.ideavimrc ~/.ideavimrc
ln -sfn ${SCRIPT_DIR} ~/.vim
ln -sfn ${SCRIPT_DIR}/tmux.conf ~/.tmux.conf

# ubuntu part
echo "Run vim +PlugInstall"
if [[ `lsb_release -si` == "Ubuntu" ]] && ! [ -x "$(command -v shellcheck)" ];
    then
    sudo apt update -y
    sudo apt install -y build-essential cmake python3-dev
    sudo apt install -y ripgrep fzf
    sudo apt install -y universal-ctags global # tags
    sudo apt install -y shellcheck
    sudo apt install -y clang-tools clang-11
fi

# wsl part
if grep -q Microsoft /proc/version; then
    win_home_path=`wslpath "$(wslvar USERPROFILE)"`
    echo ${win_home_path}
    src_path=${win_home_path}/.ideavimrc 
    dest_path="${src_path}bak${d}"
    if [ -e  "${src_path}" ]
        then cp "${src_path}" "${dest_path}"
        echo "Original ${src_path} conf has been renamed to ${dest_path}"
    fi

    # echo "You should mannually run mklink as Administrator for .ideavimrc"
    if [ -e "${win_home_path}/.ideavimrc" ]
        then cp "${win_home_path}/.ideavimrc"  "${win_home_path}/.ideavimrcbak_${d}" 
        echo "Original .ideavimrc has been renamed to .ideavimrcbak_${d}"
    fi
    cp "${SCRIPT_DIR}/pd.ideavimrc" "${win_home_path}/.ideavimrc"

    if [ -e "${win_home_path}/.vsvimrc" ]
        then cp "${win_home_path}/.vsvimrc"  "${win_home_path}/.vsvimrcbak_${d}" 
        echo "Original .vsvimrc has been renamed to .vsvimrcbak_${d}"
    fi
    cp "${SCRIPT_DIR}/pd.vsvimrc" "${win_home_path}/.vsvimrc"

    # cp "${SCRIPT_DIR}/pd.vsvimrc" "${win_home_path}/.vsvimrc"
    printf '(check_files_eq "$WINHOME/.ideavimrc" "$HOME/.vim/pd.ideavimrc" &)\n' >> ~/.bashrc_local
    printf '(check_files_eq "$WINHOME/.vsvimrc" "$HOME/.vim/pd.vsvimrc" &)\n' >> ~/.bashrc_local
fi
