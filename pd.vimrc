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

" 高亮选中
set hlsearch

" 自动换行
set wrap

" 设置默认进行大小写不敏感查找
set ignorecase
" " 如果有一个大写字母，则切换到大小写敏感查找
set smartcase
"

" 让退格键能正常退格
set backspace=indent,eol,start
" Vim默认左右方向键不会切换到下一行，调一下，让<>,h,l,[,]都可以换行
set whichwrap+=<,>,h,l,[,]

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

" 自动去除部分文件的行尾空格
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> %s/\s\+$//e

"============================================= KEYS MAPPING ==================
" 部分快捷键
" 用kj来替换ESC
inoremap kj <Esc>
" F2复制粘贴模式
set pastetoggle=<F2> 
" <F3>关闭开启数字行号
nnoremap <F2> :set nu! nu?<CR>
" :W 表示sudo权限强制保存
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" <leader>q退出
nnoremap <leader>q :q<CR>
" <leader>w保存
nnoremap <leader>w :w<CR>
" Upper U to redo
nnoremap U <C-r>

" search improvement
" 默认按/和<space>进入正则搜索
map <space> /
nnoremap / /\v
vnoremap / /\v
" <leader>/关闭搜索高亮
noremap <silent><leader>/ :nohls<CR>

" 一个我自己不太习惯的特性
" 省略一个shift
 nnoremap ; :
" 复制选中到系统剪贴板
" 需要+clipboard特性支持
" debian的包里目测只有vim-gtk带这个特性
vnoremap <leader>y "+y
"select all
map <Leader>sa ggVG"
" Shift+H goto head of the line, Shift+L goto end of the line
nnoremap H ^
nnoremap L $

" command mode, ctrl-a to head， ctrl-e to tail
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>



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
" base16主题
Plug 'chriskempson/base16-vim'
" Airline
Plug 'vim-airline/vim-airline'
" 文件树
Plug 'scrooloose/nerdtree'
" 模糊查找
" 需要GNU global配合
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" ALE 静态检查
Plug 'dense-analysis/ale'

" C++ 增强高亮
Plug 'octol/vim-cpp-enhanced-highlight'
" Cmake support
Plug 'ilyachur/cmake4vim'
" taglist
" 不需要 leaderF自带这个功能
" Plug 'liuchengxu/vista.vim'

" 代码异步格式化
Plug 'sbdchd/neoformat'

" auto pair
Plug 'jiangmiao/auto-pairs'

" GLSL support
Plug 'beyondmarc/glsl.vim'

" MOST HORRIBLE PLUGIN(NOT ACTURALLY A PLUGIN BUT A MONSTER)
Plug 'Valloric/YouCompleteMe',{'do':'./install.py --clang-completer', 'for': ['c', 'cpp']}
" 参数补全
" 不太好用
"Plug 'tenfyzhong/CompleteParameter.vim'
" ycm generator
Plug 'rdnetto/YCM-Generator',{'branch': 'stable'}

call plug#end()



" ===============================插件配置=====================================
" 主题设置
" 使用256位颜色
set termguicolors
set t_Co=256
let base16colorspace=256
colorscheme base16-oceanicnext
"colorscheme qdark


" nerdtree 配置
" 下面两行：当打开一个文件夹时，自动打开nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" <leader><n>打开nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" 关闭vim当只剩下nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" leadF配置
" 自动更新索引
let g:Lf_GtagsAutoGenerate = 1
" <leader>fr搜索光标所在词语并允许跳转
noremap <leader>fg :<C-U><C-R>=printf("Leaderf! gtags -g %s --auto-jump", expand("<cword>"))<CR><CR>

" <leader>fr搜索光标所在词语的引用并允许跳转
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>

" <leader>fr搜索光标所在词语的定义并允许跳转
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" <leader>fb 显示本文件tag
noremap <leader>fb :<C-U><C-R>=printf("LeaderfBufTag")<CR><CR>

" <leader>fp 显示本文件函数列表
noremap <leader>fp :<C-U><C-R>=printf("LeaderfFunction!")<CR><CR>

" ALE配置
" 把错误信息输出到airline上
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

" neoformat设置
" format on save
augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END

" GLSL support
let g:glsl_default_version = 'glsl330'
let g:glsl_file_extensions = '*.glsl,*.vsh,*.fsh,*.vert,*.tesc,*.tese,*.geom,*.frag,*.comp'


" Youcompleteme
" 语义补全
let g:ycm_semantic_triggers =  {
            \ 'c,cpp': ['re!\w{4}'],
            \}
" 取消ycm的静态检查，有ALE了
let g:ycm_show_diagnostics_ui = 0
"let g:ycm_min_num_identifier_candidate_chars = 2
" 用ycm generator感觉会更好
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion = ['<c-j>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>', '<c-k>']
"===============================语言配置=====================================

au bufnewfile *.sh 0r ~/.vim/template/shell.tpl
au bufnewfile *.py 0r ~/.vim/template/python.tpl
