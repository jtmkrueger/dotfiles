set nocompatible

" START vundle ----------------------------
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" syntaxes
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'pangloss/vim-javascript'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-ruby/vim-ruby.git'

" colorscheme
Bundle 'jtmkrueger/base16-vim'

" tools
Bundle 'jtmkrueger/vim-c-cr'
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
set background=dark
colorscheme base16-default
set encoding=utf-8
set fileencoding=utf-8
set t_Co=256
set laststatus=2 " show status line
" set statusline=%<%f\ %h%m%r%=%-14.(Σ=%L%)
set statusline=%<\ %F%=\ %{fugitive#statusline()}\ \|\ %{&filetype}\ \|\ LN\ %l/%L(%p%%):%c
set expandtab " use spaces instead of tab characters
set tabstop=2 softtabstop=2 shiftwidth=2
set backspace=start,eol,indent " always allow backspaces
set wildmenu " trick out command mode
set incsearch " highlight search pattern as it's typed
set ignorecase " searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter
set listchars=tab:▸\ ,trail:⋅ " trailing white space and tabs
set wrap " textwrap
set linebreak " wrap lines at spaces
set wrapmargin=0 " wrap at last column
set autoindent
set smartindent
set textwidth=0 " disable auto line breaking on paste
set formatoptions+=l " don't break lines till after insert mode
set number " line numbers
set showtabline=2 " always show tabs
set showcmd " show the command line
set scrolloff=5 " 5 line buffer below cursor when scrolling
set hlsearch " highlight search results
set cursorline " highlight line cursor is on
set colorcolumn=81 " highlight col 80
highlight ColorColumn guibg=black
set clipboard=unnamed " copy to system register
set mouse=a " turn on all mouse functionality

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Open new splits to the right/bottom
set splitright splitbelow


highlight NonText ctermfg=Red
highlight SpecialKey ctermfg=Red

" I want my custom commands!
imap <C-e> <%= %><Left><Left><Left>
imap <C-n> $()<Left>
nmap <c-cr> i<cr><Esc>

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
