"         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"                     Version 2, December 2004

"  Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

"  Everyone is permitted to copy and distribute verbatim or modified
"  copies of this license document, and changing it is allowed as long
"  as the name is changed.

"             DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

"   0. You just DO WHAT THE FUCK YOU WANT TO.


"============================================= basic settings =========================================
"禁止swap file
set noswapfile
" I don't care the f**king vi
set nocompatible

" 强化正则表达式,没有magic，正则表达式近乎无法使用
set magic

" 显示
set number      "行号
set ruler      "行号和列号

" 加大移动距离
set scrolloff=10

" 增强标题显示
set title

" 离开窗口时自动保存，回到窗口时自动更新
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

" 简写信息，并关闭乌干达可怜儿童
set shortmess+=atI

"打开自动探测文件类型和缩进
filetype on
filetype plugin on
filetype indent on

"设置leader
let mapleader = ','
let g:mapleader = ','

"设置文件编码
" 内部编码
set encoding=utf-8
" 读取文件时候顺序猜测编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 用于屏幕显示的编码
set termencoding=utf-8


" 自动缩进
set autoindent

" 高亮第80列
set colorcolumn=80

" 自动折行(这个是硬折行)
"set linebreak


" 自动换行
set wrap

" 让退格键能正常退格
set backspace=indent,eol,start
" Vim默认左右方向键不会切换到下一行，调一下，让<>,h,l,[,]都可以换行
set whichwrap+=<,>,h,l,[,]

"============================================= KEYS MAPPING ==================
" 用kj来替换ESC
inoremap kj <Esc>

" :W 表示sudo权限强制保存
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" tab替代
set expandtab "tab to spaces
set smarttab  "删除会自动删除等同于tab数量的空格
set shiftround ">>和<<会处理没对齐的情况
" indent
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces

" 简化在不同窗口中移动的操作
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" 以下来自
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
" 简化复制粘贴
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
"============================================= plugins ========================

" 安装plug.vim插件管理器，依赖curl
" 这一段必须在 plug#begin()之前
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" 在这一段需要的插件

" 颜色主题

" 插件
call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
call plug#end()



" ===============================插件配置=====================================
" 主题设置
" 使用256位颜色
set termguicolors
set t_Co=256
let base16colorspace=256
colorscheme base16-oceanicnext

" ===============================语言配置=====================================

au bufnewfile *.sh 0r ~/.vim/template/shell.tpl
au bufnewfile *.py 0r ~/.vim/template/python.tpl
