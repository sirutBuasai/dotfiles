" ═══════════════════════════════════════════════════════════════════
" ~/.vimrc — portable "stone-age" fallback (plain Vim, NO plugins)
"
" scp/curl this onto any bare box (EC2, container, devbox) to get a
" Neovim-flavored experience instantly — no plugin ecosystem to install.
" Mirrors the core options / keymaps / muscle memory of the full Neovim
" config, and degrades gracefully when a feature isn't compiled in.
" ═══════════════════════════════════════════════════════════════════

set nocompatible
syntax enable
filetype plugin indent on

let mapleader = " "
let maplocalleader = ","

" ── Core options ─────────────────────────────────────────────────────
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

" wrapping (on) — readable wrapped lines where supported
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
set path+=**                       " lets :find search recursively
set iskeyword+=-
set shortmess+=c
set formatoptions-=cro

" no backup/swap; keep persistent undo in a real directory
set nobackup nowritebackup noswapfile
if has('persistent_undo')
  set undofile
  let &undodir = expand('~/.vim/undo')
  silent! call mkdir(&undodir, 'p')
endif

" jumplist like a browser (Vim >= 8.1.2622)
if exists('&jumpoptions') | set jumpoptions=stack | endif

" system clipboard only if compiled in (bare servers often lack +clipboard)
if has('clipboard') | set clipboard=unnamedplus | endif

" truecolor only when the terminal advertises it
if has('termguicolors') && $COLORTERM =~# 'truecolor\|24bit'
  set termguicolors
endif

" ripgrep for :grep when present
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" keep comment-continuation off even after filetype plugins reset it
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" built-in colorscheme (silent so it never errors on older Vim)
silent! colorscheme habamax

" ── Netrw file explorer (built-in — stands in for nvim-tree) ─────────
let g:netrw_banner = 0
let g:netrw_liststyle = 3     " tree view
let g:netrw_winsize = 25
nnoremap <leader>t :Lexplore<CR>

" ── Keymaps (mirror the Neovim config) ───────────────────────────────
" Shift-h/l to line ends
noremap <S-h> ^
noremap <S-l> $
" operate to line ends
nnoremap dH d^
nnoremap dL d$
nnoremap cH c^
nnoremap cL c$

" splits + window nav (plain <C-w> — no smart-splits here)
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>hs :split<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" change/delete word under cursor, dot-repeatable
nnoremap c* *``cgn
nnoremap d* *``dgn
nnoremap c# #``cgN
nnoremap d# #``dgN

" misc
nnoremap \ ggVG
nnoremap q: <nop>
nnoremap <C-q> :q<CR>

" spell
nnoremap <leader>ss :set spell<CR>
nnoremap <leader>ns :set nospell<CR>

" black-hole delete/paste (don't clobber the yank register)
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

" fuzzy-ish file find (uses path+=**) and project grep
nnoremap <leader>ff :find
nnoremap <leader>fg :grep

" terminal (if compiled): Esc to normal mode, <C-hjkl> window nav
if has('terminal')
  tnoremap <Esc> <C-w>N
  tnoremap <C-h> <C-w>h
  tnoremap <C-j> <C-w>j
  tnoremap <C-k> <C-w>k
  tnoremap <C-l> <C-w>l
endif

" ── Typo-tolerant write/quit (forwards a trailing !) ─────────────────
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Q  q<bang>
command! -bang WA wa<bang>
command! -bang Wa wa<bang>
command! -bang W  w<bang>
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>

" ── Minimal statusline (mode shown by 'showmode') ────────────────────
set statusline=%f\ %m%r%h%w%=%y\ %l:%c\ %P
