" Configuration -------------------------------------------
set autoindent                    " Set auto indentation
set backspace=indent,eol,start    " Allow backspace to work as normal
set nobackup                      " Creates a backup file
set clipboard=unnamedplus         " Allows vim to access the system clipboard
set completeopt=menuone,noselect  " Mostly just for cmp
set conceallevel=0                " So that `` is visible in markdown files
set cursorline                    " Highlight the current line
set encoding=utf-8                " Display encoding
set expandtab                     " Convert tabs to spaces
set fileencoding=utf-8            " The encoding written to a file
set hidden                        " Required to keep multiple buffers open
set hlsearch                      " Highlight all matches on previous search pattern
set ignorecase                    " Ignore case in search patterns
set laststatus=2                  " Always display last status
set modifiable                    " Set buffer modifible
set mouse=a                       " Allow the mouse to be used in vim
set number                        " Set numbered lines
set numberwidth=4                 " Set number column width to 3 {default 4}
set pumheight=10                  " Pop up menu height
set norelativenumber              " Set relative numbered lines
set ruler                         " Show cursor position at all times
set scrolloff=8                   " Minimal number of screen lines to keep above and below the cursor
set shiftwidth=2                  " The number of spaces inserted for each indentation
set noshowmode                    " We don't need to see things like -- INSERT -- anymore
set sidescrolloff=8               " Minimal number of screen columns either side of cursor if wrap is `false`
set signcolumn=auto               " Always show the sign column, otherwise it would shift the text each time
set smartcase                     " Smart case
set smartindent                   " Make indenting smarter again
set smarttab                      " Auto detect tab sizes
set softtabstop=2                 " Number of spaces inserted instead of a tab character
set splitbelow                    " Force all horizontal splits to go below current window
set splitright                    " Force all vertical splits to go to the right of current window
set noswapfile                    " Creates a swapfile
set tabstop=2                     " Insert 2 spaces for a tab
set timeoutlen=500                " Time to wait for a mapped sequence to complete (in milliseconds)
set undofile                      " Enable persistent undo
set updatetime=250                " Faster completion (4000ms default)
set nowrap                        " Display long lines instead of one line
set nowritebackup                 " If a file is being edited by another program, it is not allowed to be edited
set nolist                        " Remove ^I from indentation
set noundofile                    " Remove .un files

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
