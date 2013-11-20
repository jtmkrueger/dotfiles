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
Bundle 'nono/vim-handlebars'

" colorschemes
Bundle 'altercation/vim-colors-solarized'
Bundle 'jtmkrueger/base16-vim'

" tools
Bundle 'jtmkrueger/vim-c-cr'
Bundle 'mileszs/ack.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
" Bundle 'mattn/emmet-vim'
Bundle 'tristen/vim-sparkup'
Bundle 'sjl/vitality.vim'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-commentary.git'
filetype plugin indent on
" END vundle ------------------------

syntax on
set shell=/bin/bash
set background=dark
colorscheme base16-default
set encoding=utf-8
set fileencoding=utf-8
set t_Co=256
set autoread " auto read when a file is changed from the outside
set magic "for regular epressions turn magic on
set laststatus=2 " show status line
set statusline=%<\ %F%m%=\ \|\⅄%{fugitive#head()}\ \|\⨍%{&filetype}\ 
hi StatusLine ctermfg=DarkBlue  ctermbg=236
" change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermfg=black ctermbg=DarkBlue
  au InsertLeave * hi StatusLine term=reverse ctermfg=DarkBlue ctermbg=236
endif
set expandtab " use spaces instead of tab characters
set tabstop=2 softtabstop=2 shiftwidth=2
set smarttab " start tabbed in
set backspace=start,eol,indent " always allow backspaces
set wildmenu " trick out command mode
set incsearch " highlight search pattern as it's typed
set ignorecase " searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter
set listchars=tab:▸\ ,trail:⋅ " trailing white space and tabs
highlight NonText ctermfg=Red
highlight SpecialKey ctermfg=Red
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
set cursorcolumn " highlight the cursors current col
set clipboard=unnamed " copy to system register
set mouse=a " turn on all mouse functionality
set timeoutlen=300 " Time to wait after ESC (default causes an annoying delay)

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Open new splits to the right/bottom
set splitright splitbelow

" I want my custom commands!
imap <C-e> <%= %><Left><Left><Left>

" easy search
nnoremap <c-a> :Ack!<Space>

" cycle through buffers
nnoremap <C-n> :bnext<CR>

" up/down on wrapped lines
nnoremap j gj
nnoremap k gk

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" make . work in visual mode
:vnoremap . :norm.<cr>

" visual mode macro execution
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" clear search highlights with enter
nnoremap <CR> :nohlsearch<CR>/<BS>

" make resizing windows a bit easier
noremap <left> <C-w>>
noremap <right> <C-w><
noremap <up> <C-w>-
noremap <down> <C-w>+

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_javascript_checkers = ['jsl']
let g:syntastic_quiet_warnings=1
let g:syntastic_ruby_exec = '~/usr/local/var/rbenv/versions/1.9.3-p194/bin/ruby'

augroup sparkup_types
  " Remove ALL autocommands of the current group.
  autocmd!
  " Add sparkup to new filetypes
  autocmd FileType ruby,eruby,erb,js runtime! ftplugin/html/sparkup.vim
augroup END
