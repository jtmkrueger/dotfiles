set nocompatible

" START vundle ----------------------------
filetype off
set rtp+=~/.nvim/bundle/vundle/
call vundle#rc("~/.nvim/bundle")
Bundle 'gmarik/vundle'

" syntaxes
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'pangloss/vim-javascript'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-ruby/vim-ruby.git'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'briancollins/vim-jst'

" colorschemes
Bundle 'jtmkrueger/base16-vim'

" tools
Bundle 'jtmkrueger/vim-c-cr'
Bundle 'mileszs/ack.vim'
Bundle 'shougo/neocomplcache'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'ivyl/vim-bling'
Bundle 'szw/vim-tags'
Bundle 'blueyed/vim-diminactive'

Bundle 'mattn/emmet-vim'
Bundle 'sjl/vitality.vim'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-commentary.git'
filetype plugin indent on
" END vundle ------------------------

syntax on
set ttyfast
set lazyredraw
set shell=/bin/bash
set background=dark
colorscheme base16-default
set encoding=utf-8
set fileencoding=utf-8
set t_Co=256
set autoread " auto read when a file is changed from the outside
set magic "for regular epressions turn magic on

" statusline
set laststatus=2 " show status line
set statusline=%<\ %f%m%=\ \\ \\ \\ \⨍\ %{&filetype}\ \\ \c\o\l\:\ %c\ \\ \l\i\n\e\/\t\o\t\a\l\:\ %l\/%L\ \\ %p%%
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
set wrap " textwrap
" set to no show for speed
hi NonText cterm=NONE ctermfg=NONE
set linebreak " wrap lines at spaces
set wrapmargin=0 " wrap at last column
set autoindent
set smartindent
set textwidth=0 " disable auto line breaking on paste
set formatoptions+=l " don't break lines till after insert mode
set number " line numbers
set relativenumber " show relative line number in gutter
set showtabline=2 " always show tabs
set showcmd " show the command line
set scrolloff=5 " 5 line buffer below cursor when scrolling
set hlsearch " highlight search results
set cursorline " highlight line cursor is on
set cursorcolumn " highlight the cursors current col
set clipboard=unnamed " copy to system register
set mouse=a " turn on all mouse functionality
set timeoutlen=300 " Time to wait after ESC (default causes an annoying delay)
set omnifunc=syntaxcomplete#Complete

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" map leader to space
let mapleader = "\<Space>"

" leader mappings
nnoremap <leader>v :vs<space>
nnoremap <leader>t :tabe<space>
nnoremap <leader>s :sp<space>

" Open new splits to the right/bottom
set splitright splitbelow

" I want my custom commands!
imap <C-s> <%= %><Left><Left><Left>

" easy search with the silver searcher
let g:ackprg = 'ag --nogroup --column'
nnoremap <c-a> :Ack!<Space>

" up/down on wrapped lines
nnoremap j gj
nnoremap k gk

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" make . work in visual mode
:vnoremap . :norm.<cr>

" clear search highlights with enter
nnoremap <CR> :nohlsearch<CR>/<BS>

" make resizing windows a bit easier
noremap <left> <C-w>>
noremap <right> <C-w><
noremap <up> <C-w>-
noremap <down> <C-w>+

" syntastic
let g:syntastic_always_populate_loc_list=1

" catch very long wrapped lines with diminactive
let g:diminactive_max_cols = 1000
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_quiet_messages = {'level': 'warnings'}

let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" emmet expansions
imap <expr> <C-e> emmet#expandAbbrIntelligent("\<C-e>")

" set tmux window name automatically
augroup Tmux "{{{2
  au!

  autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim-' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
  autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END
