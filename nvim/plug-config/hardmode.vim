let g:HardMode_level = 'wannabe'
let g:HardMode_hardmodeMsg = 'Don''t use this!'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

