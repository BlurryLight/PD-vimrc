" modified from
" - https://vim.fandom.com/wiki/Creating_your_own_syntax_files#Install_the_syntax_file
" - https://github.com/beyondmarc/hlsl.vim
" Read the C syntax to start with
"
if exists("b:current_syntax")
    finish
endif


" Intrinsic functions
syn keyword    MonkeyFunc fn
syn keyword    MonkeyStatement let return
syn keyword    MonkeyRepeat while   
syn keyword    MonkeyCondition if else
syn keyword    MonkeyBoolean true false
syn match   MonkeyLineComment      "\/\/.*"
syn match MonkeyCall "\zs\(\k\w*\)*\s*\ze("
syntax region MonkeyString   start=+"+  skip=+\\"+  end=+"+

" syntax match MonkeyString ".*"
hi def link MonkeyStatement Statement
hi def link MonkeyRepeat Repeat
hi def link MonkeyString String
hi def link MonkeyFunc Function
hi def link MonkeyCall Function
hi def link MonkeyCondition Conditional
hi def link MonkeyBoolean Boolean
hi def link MonkeyLineComment Comment


let b:current_syntax = "monkey"
