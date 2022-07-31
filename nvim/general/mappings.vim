" Set leader key
let mapleader = " "

" Switching between buffers
" Currently using cybu instead
" nnoremap <C-n> :bnext<CR>                   " Ctrl+n to go to next buffer
" nnoremap <C-b> :bprevious<CR>               " Ctrl+b to go to previous buffer

" Window navigation
nnoremap <C-h> <C-w>h                       " Ctrl+h to go to left window
nnoremap <C-j> <C-w>j                       " Ctrl+j to go to bottom window
nnoremap <C-k> <C-w>k                       " Ctrl+k to go to top window
nnoremap <C-l> <C-w>l                       " Ctrl+l to go to right window

" Window resizing
nnoremap <S-Up> :resize +2<CR>              " Resize up
nnoremap <S-Down> :resize -2<CR>            " Resize down
nnoremap <S-Left> :vertical resize +2<CR>   " Resize left
nnoremap <S-Right> :vertical resize -2<CR>  " Resize right

" Spell checking
nnoremap <leader>ss :set spell<CR>          " Enable spell checking
nnoremap <leader>ns :set nospell<CR>        " Disable spell cheking

" Lazy shift fingers
:command WQ wq                              " Allows WQ to write and quit
:command Wq wq                              " Allows Wq to write and quit
:command W w                                " Allows W to write
:command Q q                                " Allows Q to quit

" Window splitting
nnoremap <leader>vs :vs<CR>                 " Split window vertically
nnoremap <leader>hs :sp<CR>                 " Split window horizontally

" Replace words
" Replace current word and move to the next occurence
nnoremap c* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgn
" Replace current word and move to the previous occurence
nnoremap c# ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgN

" Highlight the whole file
nmap - ggVG<CR>                             " Highlight the whole file

" Remove command history
nnoremap q: <nop>
