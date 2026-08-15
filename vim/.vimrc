set nocompatible
syntax enable
filetype plugin indent on

let mapleader = " "
let maplocalleader = ","

" -- Core options ------------------------------------------------------
set encoding=utf-8
set number
set norelativenumber
set numberwidth=3
set cursorline

" 2-space soft tabs
set expandtab shiftwidth=2 tabstop=2 softtabstop=2
set smartindent autoindent smarttab

" search
set ignorecase smartcase
set hlsearch incsearch

" wrapping
set wrap
if exists('&breakindent') | set breakindent linebreak | endif

set scrolloff=8 sidescrolloff=8
set splitbelow splitright
set hidden
set mouse=a
set backspace=indent,eol,start
set laststatus=2
if exists('&signcolumn') | set signcolumn=yes | endif
set updatetime=250 timeoutlen=500
set confirm
set completeopt=menuone,noselect
set wildmenu wildmode=longest:full,full
set path+=** " lets :find search recursively
set iskeyword+=-
set shortmess+=c
set formatoptions-=cro

" no backup/swap
set nobackup nowritebackup noswapfile
if has('persistent_undo')
  set undofile
  let &undodir = expand('~/.vim/undo')
  silent! call mkdir(&undodir, 'p')
endif

" jumplist as stack
if exists('&jumpoptions') | set jumpoptions=stack | endif

" system clipboard only
if has('clipboard') | set clipboard=unnamedplus | endif

" truecolor
if has('termguicolors') && $COLORTERM =~# 'truecolor\|24bit'
  set termguicolors
endif

" ripgrep for :grep
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" keep comment-continuation off
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" built-in colorscheme
silent! colorscheme habamax

" -- Netrw file explorer -----------------------------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
nnoremap <leader>t :Lexplore<CR>

" -- Keymaps -----------------------------------------------------------
" Shift-h/l to line ends
noremap <S-h> ^
noremap <S-l> $
" operate to line ends
nnoremap dH d^
nnoremap dL d$
nnoremap cH c^
nnoremap cL c$

" splits + window nav
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>hs :split<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" change/delete word under cursor
nnoremap c* *``cgn
nnoremap d* *``dgn
nnoremap c# #``cgN
nnoremap d# #``dgN

" misc
nnoremap \ ggVG
nnoremap q: <nop>
nnoremap <C-q> :q<CR>
" save a file you forgot to sudo
cnoremap w!! w !sudo tee > /dev/null %
" make Y behave like C/D (yank to EOL)
nnoremap Y y$
" clear search highlight
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" spell
nnoremap <leader>ss :set spell<CR>
nnoremap <leader>ns :set nospell<CR>

" black-hole delete/paste
nnoremap <leader>dd "_dd
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

" move & re-indent the visual selection
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv
xnoremap < <gv
xnoremap > >gv

" keep the cursor centered / in place
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap J mzJ`z

" fuzzy-ish file find
nnoremap <leader>ff :find<Space>
nnoremap <leader>fg :grep<Space>

" terminal nav
if has('terminal')
  tnoremap <Esc> <C-w>N
  tnoremap <C-h> <C-w>h
  tnoremap <C-j> <C-w>j
  tnoremap <C-k> <C-w>k
  tnoremap <C-l> <C-w>l
endif

" -- Typos -------------------------------------------------------------
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Q  q<bang>
command! -bang WA wa<bang>
command! -bang Wa wa<bang>
command! -bang W  w<bang>
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>

" -- Statusline --------------------------------------------------------
set statusline=%f\ %m%r%h%w%=%y\ %l:%c\ %P
