set nocompatible

" START vundle ----------------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
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
Plugin 'altercation/vim-colors-solarized'

" tools
Plugin 'jtmkrueger/vim-c-cr'
Plugin 'mileszs/ack.vim'
" Plugin 'scrooloose/syntastic'
Plugin 'neomake/neomake'
Plugin 'Shougo/deoplete.nvim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'szw/vim-tags'
Plugin 'bling/vim-airline'
Plugin 'schickling/vim-bufonly'

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
let g:python3_host_prog = '/opt/pkg/bin/python'
set ttyfast
set lazyredraw
set shell=/bin/bash
set background=dark
" let g:hybrid_use_iTerm_colors = 1
" let g:hybrid_use_Xresources = 1
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid
set encoding=utf-8
set fileencoding=utf-8
set t_Co=256
"set term=xterm-256color
" set autoread " auto read when a file is changed from the outside
set magic "for regular epressions turn magic on
set laststatus=2 " turn on statusline
set noerrorbells " no errorbells!
set vb t_vb= " seriously, no errorbells!!

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
set autoread " automatically reads file in
set cmdheight=1
set smartindent
set textwidth=0 " disable auto line breaking on paste
" set formatoptions+=l " don't break lines till after insert mode
set number " line numbers
" set relativenumber " show relative line number in gutter
set showtabline=2 " always show tabs
set scrolloff=5 " 5 line buffer below cursor when scrolling
set hlsearch " highlight search results
set cursorline " highlight line cursor is on
set cursorcolumn " highlight the cursors current col
set clipboard=unnamed " copy to system register
set mouse=a " turn on all mouse functionality
set timeoutlen=300 " Time to wait after ESC (default causes an annoying delay)

" " Resize splits when the window is resized
au VimResized * :wincmd =

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" map leader to space
let mapleader = "\<Space>"

" leader mappings
nnoremap <leader>v :vs<space>
nnoremap <leader>s :sp<space>
nnoremap <leader>t :tabe<space>
nnoremap <leader>V :Vex<CR>
nnoremap <leader>S :Sex<CR>
nnoremap <leader>T :Tex<CR>

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

" catch very long wrapped lines with diminactive
let g:diminactive_max_cols = 1000

" togglecursor
let g:togglecursor_default = 'blinking_block'

" syntastic
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_enable_signs=1
" let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
" let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_ruby_checkers = ['mri'] " ... we'll see
let g:syntastic_eruby_checkers = ['mri']
let g:syntastic_scss_checkers = ['sassc']
let g:syntastic_ruby_exec = "/usr/local/var/rbenv/versions/2.0.0-p481/bin/ruby"
let g:syntastic_javascript_checkers = ['jshint']

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_refresh_always = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" easytags
let g:easytags_cmd = 'exctags'
set tags=./tags;
let g:easytags_dynamic_files = 1
let g:easytags_async = 1

" emmet expansions
" imap <expr> <C-e> emmet#expandAbbrIntelligent("\<C-e>")
let g:user_emmet_leader_key = '<c-e>'

" delimate
" let g:delimitMate_expand_cr = 1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1
" let g:airline#extensions#whitespace#enabled = 0
" let g:airline_section_warning=""
" let g:airline#extensions#syntastic#enabled = 0

" neomake
autocmd! BufWritePost,BufEnter * Neomake
" let g:neomake_verbose=3 " enable for debugging
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_json_enabled_makers = ['jsonlint']

" set tmux window name automatically
augroup Tmux "{{{2
  au!
  autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim-' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
  autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END
