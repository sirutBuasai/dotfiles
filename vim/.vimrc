" Configuration -------------------------------------------
set number
set tabstop=2
set expandtab
set autoindent
set shiftwidth=2
set backspace=2

" Mappings ------------------------------------------------
let mapleader = " "

" Line navigation -----------------------------------------
" H to move to start of line
noremap <S-h> ^
" L to move to end of line
noremap <S-l> $

" Extend custom line navigation ---------------------------
" dH to delete to start of line
nnoremap d<S-h> d^
" dL to delete to end of line
nnoremap d<S-l> d$
" cH to change to start of line
nnoremap c<S-h> c^
" cL to change to end of line
nnoremap c<S-l> c$

" Spell checking ------------------------------------------
" Enable spell checking
vim.keymap.set(n, "<leader>ss", ":set spell<CR>", noremap)
" Disable spell cheking
vim.keymap.set(n, "<leader>ns", ":set nospell<CR>", noremap)

" Lazy shift fingers --------------------------------------
" Allows QA to quit all
command! QA qa
" Allows Qa to quit all
command! Qa qa
" Allows Q to quit
command! Q q
" Allows WA to write all
command! WA wa
" Allows Qa to write all
command! Wa wa
" Allows W to write
command! W w
" Allows WQ to write and quit
command! WQ wq
" Allows Wq to write and quit
command! Wq wq

" Replace words -------------------------------------------
" Replace current word and move to the next occurence
nnoremap c* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgn
" Replace current word and move to the previous occurence
nnoremap c# ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgN

" Highlight the whole file --------------------------------
nnoremap \ ggVG

" Remove command history ----------------------------------
nnoremap q: <nop>

" Delete and paste text without yanking -------------------
" Delete without yanking
nnoremap <leader>dd "_dd
vnoremap <leader>d "_d
" Replace currently selected text without yanking
vnoremap <leader>p "_dP
