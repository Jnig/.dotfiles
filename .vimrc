set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'Raimondi/delimitMate'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'leafgarland/typescript-vim'
"Plugin 'Quramy/tsuquyomi'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
call vundle#end()            " required
filetype plugin indent on    " required

" open nerdtree auto
"autocmd vimenter * NERDTree

" space instead of tab
set expandtab
set shiftwidth=2
set tabstop=2
" vim colors solarized
syntax enable
"set background=dark
"colorscheme solarized

" line numbers
set number

" autowrite buffers
set autowriteall
 
if has('gui_running')
	" do something
else
  	" in terminal mode
	set t_Co=256
	let g:solarized_termcolors=256
endif

let g:indent_guides_enable_on_vim_startup = 1


" breaking habit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" complete
let g:ycm_autoclose_preview_window_after_completion=1

" execute current file
nnoremap <F9> :!%:p

"airline
let g:airline#extensions#tabline#enabled = 1
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 11 
set laststatus=2
let g:airline_powerline_fonts = 1

"vim copy paste to external
set clipboard=unnamedplus

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
