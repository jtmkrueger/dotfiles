set nocompatible

" vundle ----------------------------
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" syntaxes
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'pangloss/vim-javascript'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-ruby/vim-ruby.git'

" tools
Bundle 'mileszs/ack.vim'
Bundle 'ervandew/supertab.git'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/zencoding-vim.git'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-commentary.git'
filetype plugin indent on
" END vundle ------------------------

syntax on
set encoding=utf-8
set t_Co=256
set laststatus=2
" change status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=5
  au InsertLeave * hi StatusLine ctermfg=2
endif
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
set backspace=start,eol,indent
set wildmenu
set listchars=tab:▸\ ,trail:⋅ " trailing white space and tabs
set wrap
set linebreak
set autoindent
set smartindent
set textwidth=0
set wrapmargin=0
set formatoptions+=l
set number
set showtabline=2
set hlsearch
set cursorline

" what happens when you have a govenrnment computer :(
set nobackup
set nowritebackup

" Open new splits to the right/bottom
set splitright splitbelow
set clipboard=unnamed
set mouse=a

highlight NonText ctermfg=Red
highlight SpecialKey ctermfg=Red

" I want my custom commands!
imap <C-e> <%= %><Left><Left><Left>
imap <C-n> $()<Left>

" up/down on wrapped lines
nnoremap j gj
nnoremap k gk

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" clear search highlights with enter
nnoremap <CR> :nohlsearch<CR>/<BS>

" make resizing windows a bit easier
noremap <left> <C-w>>
noremap <right> <C-w><
noremap <up> <C-w>-
noremap <down> <C-w>+

function Closer()
  let  prevchar = getline(".")[col(".")-2]
  if prevchar ==# "{"
  elseif prevchar ==# "["
  elseif prevchar ==# "("
  endif
endfunction
