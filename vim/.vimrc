" Vundle auto setup ------------------------------------------------------------------------------
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/

call vundle#begin()
" Add plugins here
Plugin 'VundleVim/Vundle.vim'
Plugin 'valloric/youcompleteme'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'

if iCanHazVundle == 0
  echo "Installing Vundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

call vundle#end()

" Set env ---------------------------------------------------------------------------------------
set number
set tabstop=2
set expandtab
set autoindent
set shiftwidth=2
set backspace=2

" Set color schemes and visuals -----------------------------------------------------------------
colorscheme molokai
syntax on
highlight Normal ctermbg=None
highlight LineNr ctermfg=Grey ctermbg=Black

" Youcompleteme Settings ------------------------------------------------------------------------
nnoremap <C-z> :pclose<CR>
set completeopt-=preview

" NERDTree settings -----------------------------------------------------------------------------
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
