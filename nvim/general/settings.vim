syntax enable               " Enable Syntax highlighting
set hidden                  " Required to keep multiple buffers open
set nowrap                  " Display long lines instead of one line
set encoding=utf-8          " Display encoding
set pumheight=10            " Minimal popup menu
set fileencoding=utf-8      " Encoding written to file
set ruler                   " Show cursor position at all times
set cmdheight=2             " More space to display messages
set iskeyword+=-            " Treat - separated word as a word object
set splitbelow              " Force split screen downwards
set splitright              " Force split screen rightwards
set conceallevel=0          " See `` in markdown
set tabstop=2               " Set tabs to 2 spaces
set shiftwidth=2            " Set number of spaces characters in indentation
set smarttab                " Auto detect tab sizes
set expandtab               " Convert tabs to spaces
set autoindent              " Set auto indentation
set laststatus=0            " Always display last status
set number                  " Display line numbers
set cursorline              " Highlighting of the current line
set updatetime=300          " Faster autocompletion
set clipboard=unnamedplus   " Use global clipboard

" checkhealth python3
let g:python3_host_prog = '/opt/homebrew/lib/python3.9/site-packages'

