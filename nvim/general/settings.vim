syntax enable                   " Enable Syntax highlighting
set hidden                      " Required to keep multiple buffers open
set nowrap                      " Display long lines instead of one line
set encoding=utf-8              " Display encoding
set pumheight=10                " Minimal popup menu
set fileencoding=utf-8          " Encoding written to file
set ruler                       " Show cursor position at all times
set cmdheight=1                 " More space to display messages
set iskeyword+=-                " Treat - separated word as a word object
set splitbelow                  " Force split screen downwards
set splitright                  " Force split screen rightwards
set conceallevel=0              " See `` in markdown
set tabstop=2                   " Set tabs to 2 spaces
set shiftwidth=2                " Set number of spaces characters in indentation
set smarttab                    " Auto detect tab sizes
set expandtab                   " Convert tabs to spaces
set autoindent                  " Set auto indentation
set laststatus=2                " Always display last status
set number                      " Display line numbers
set signcolumn=yes              " Allow icons to be shown next to line numbers
set cursorline                  " Highlighting of the current line
set updatetime=300              " Faster autocompletion
set timeoutlen=500              " Set timeoutlen for key mappins (default = 1000ms)
set clipboard=unnamedplus       " Use global clipboard
set formatoptions-=cro          " Disaple comments continuation on new line
set mouse=a                     " Enable mouse withing vim
set backspace=indent,eol,start  " Allow backspace to work as normal
