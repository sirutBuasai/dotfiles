" Set leader key
let mapleader = " "

" Switching between buffers ----------------------------------
" Currently using cybu instead
" Ctrl+n to go to next buffer
" nnoremap <C-n> :bnext<CR>
" Ctrl+b to go to previous buffer
" nnoremap <C-b> :bprevious<CR>

" Window navigation ----------------------------------------
" Ctrl+h to go to left window
nnoremap <C-h> <C-w>h
" Ctrl+j to go to bottom window
nnoremap <C-j> <C-w>j
" Ctrl+k to go to top window
nnoremap <C-k> <C-w>k
" Ctrl+l to go to right window
nnoremap <C-l> <C-w>l

" Terminal navigation --------------------------------------
" Ctrl+h to go to left window
tnoremap <C-h> <cmd>wincmd h<CR>
" Ctrl+j to go to bottom window
tnoremap <C-j> <cmd>wincmd j<CR>
" Ctrl+k to go to top window
tnoremap <C-k> <cmd>wincmd k<CR>
" Ctrl+l to go to right window
tnoremap <C-l> <cmd>wincmd l<CR>
" Esc to go to normal mode in terminal
tnoremap <esc> <C-\><C-n>

" Line navigation ------------------------------------------
" H to move to start of line
nnoremap <S-h> ^
" L to move to end of line
nnoremap <S-l> $
" H to move to start of line
vnoremap <S-h> ^
" L to move to end of line
vnoremap <S-l> $

" Extend custom line navigation ----------------------------
" dH to delete to start of line
nnoremap d<S-h> d^
" dL to delete to end of line
nnoremap d<S-l> d$
" cH to change to start of line
nnoremap c<S-h> d^
" cL to change to end of line
nnoremap c<S-l> d$

" Window resizing ------------------------------------------
" Resize up
nnoremap <S-Up> :resize +2<CR>
" Resize down
nnoremap <S-Down> :resize -2<CR>
" Resize left
nnoremap <S-Left> :vertical resize +2<CR>
" Resize right
nnoremap <S-Right> :vertical resize -2<CR>

" Spell checking -------------------------------------------
" Enable spell checking
nnoremap <leader>ss :set spell<CR>
" Disable spell cheking
nnoremap <leader>ns :set nospell<CR>

" Lazy shift fingers ---------------------------------------
" Allows QA to quit all
:command QA qa
" Allows Qa to quit all
:command Qa qa
" Allows Q to quit
:command Q q
" Allows WA to write all
:command WA wa
" Allows Qa to write all
:command Wa wa
" Allows W to write
:command W w
" Allows WQ to write and quit
:command WQ wq
" Allows Wq to write and quit
:command Wq wq

" Window splitting -----------------------------------------
" Split window vertically
nnoremap <leader>vs :vs<CR>
" Split window horizontally
nnoremap <leader>hs :sp<CR>

" Replace words --------------------------------------------
" Replace current word and move to the next occurence
nnoremap c* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgn
" Replace current word and move to the previous occurence
nnoremap c# ?\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgN

" Highlight the whole file ---------------------------------
nmap \ ggVG<CR>

" Remove command history -----------------------------------
nnoremap q: <nop>

" Get highlight groups under cursor ------------------------
nnoremap <leader>col :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
