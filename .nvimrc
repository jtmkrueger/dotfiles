set nocompatible

runtime! plugin/python_setup.vim

" START vundle ----------------------------
filetype off
set rtp+=~/.nvim/bundle/vundle
let path='~/.nvim/bundle'
call vundle#begin(path)
Plugin 'gmarik/vundle'

" syntaxes
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'pangloss/vim-javascript'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'briancollins/vim-jst'

" colorschemes
Plugin 'w0ng/vim-hybrid'

" tools
Plugin 'jtmkrueger/vim-c-cr'
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'szw/vim-tags'
Plugin 'bling/vim-airline'
Plugin 'schickling/vim-bufonly'
Plugin 'Yggdroot/indentLine'
Plugin 'osyo-manga/vim-brightest'

Plugin 'ryanss/vim-hackernews'

Plugin 'mattn/emmet-vim'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-commentary.git'
call vundle#end()
filetype plugin indent on
" END vundle ------------------------

syntax on
set ttyfast
set lazyredraw
set shell=/bin/bash
let g:hybrid_use_iTerm_colors = 1
" let g:hybrid_use_Xresources = 1
colorscheme hybrid
set encoding=utf-8
set fileencoding=utf-8
set t_Co=256
set autoread " auto read when a file is changed from the outside
set magic "for regular epressions turn magic on
set laststatus=2 " turn on statusline
set noerrorbells " no errorbells!
set vb t_vb= " seriously, no errorbells!!

set expandtab " use spaces instead of tab characters
set tabstop=2 softtabstop=2 shiftwidth=2
set smarttab " start tabbed in
set backspace=start,eol,indent " always allow backspaces
set listchars=tab:→\ ,trail:·
set list
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
" set relativenumber " show relative line number in gutter
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

" for xlsx templates
au! BufNewFile,BufRead *.axlsx set filetype=ruby

" Store temporary files in a central spot
" set backup
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" map leader to space
let mapleader = "\<Space>"

" leader mappings
nnoremap <leader>v :vs<space>
" nnoremap <leader>V :Vex<CR>
nnoremap <leader>t :tabe<space>
nnoremap <leader>s :sp<space>
" nnoremap <leader>S :Sex<CR>

" buffer navigation
nnoremap <leader>n :bnext<CR>
nnoremap <leader>b :bprevious<CR>
nnoremap <leader>c :bp\|bd #<CR>
nnoremap <leader>o :Bonly<CR>

" Open new splits to the right/bottom
set splitright splitbelow

" I want my custom commands!
imap <C-t> <%= %><Left><Left><Left>

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

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

noremap <TAB> % " easer to hit

let g:brightest#highlight_in_cursorline = {"group": "BrightestCursorLineBg"}
let g:brightest#highlight = {"group": "BrightestUnderline"}

let g:indentLine_char = '┊'
let g:indentLine_color_term = 235
let g:indentLine_noConcealCursor = 1

" syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚐'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open=0
let g:syntastic_ruby_exec = "/usr/local/var/rbenv/versions/2.0.0-p598/bin/ruby"
let g:syntastic_ruby_checkers = ['rubylint'] " ... we'll see
let g:syntastic_eruby_checkers = ['rubylint']
" let g:syntastic_scss_checkers = ['sassc']
" let g:syntastic_eruby_ruby_exec = 'rubylint'
let g:syntastic_javascript_checkers = ['jshint']

" One day, but it just crushes my ram :(
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_filetype_blacklist = {'log': 1}

" Try and make omnifunc as smart as possible
setlocal omnifunc=syntaxcomplete#Complete
if has("autocmd")
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    autocmd FileType ruby let g:rubycomplete_rails = 1
    autocmd FileType ruby let g:rubycomplete_completions = 1
    autocmd FileType ruby let g:rubycomplete_buffer_loading=1
    autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif

let g:ycm_seed_identifiers_with_syntax = 1

let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', '*.log']

" emmet expansions
" imap <expr> <C-e> emmet#expandAbbrIntelligent("\<C-e>")
let g:user_emmet_leader_key = '<c-e>'

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1
