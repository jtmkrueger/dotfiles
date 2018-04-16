" START plug ----------------------------
call plug#begin('~/.vim/plugged')

" syntaxes
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'mxw/vim-jsx'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'briancollins/vim-jst'
Plug 'tmux-plugins/vim-tmux'
Plug 'chrisbra/csv.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

" colorschemes
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'

" tools
Plug 'jtmkrueger/vim-c-cr'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'schickling/vim-bufonly'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'jszakmeister/vim-togglecursor'
" Plug 'blueyed/vim-diminactive'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/vim-cursorword'
Plug 'Yggdroot/indentLine'
Plug 'elzr/vim-json'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" all that tpope!
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
call plug#end()
" END plug ------------------------

let g:python3_host_prog = '/opt/pkg/bin/python'
set ttyfast
set lazyredraw
set shell=/bin/bash
syntax enable
let g:hybrid_use_Xresources = 1
let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1
set background=dark
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

set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab " use spaces instead of tab characters
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
set relativenumber " line numbers
" highlight SignColumn ctermbg=black
set showtabline=2 " always show tabs
set scrolloff=5 " 5 line buffer below cursor when scrolling
set hlsearch " highlight search results
set cursorline " highlight line cursor is on
set cursorcolumn " highlight the cursors current col
set clipboard=unnamedplus " copy to system register
set mouse=a " turn on all mouse functionality
set timeoutlen=300 " Time to wait after ESC (default causes an annoying delay)
set list
set listchars=tab:⬝➜
set conceallevel=0

" " Resize splits when the window is resized
au VimResized * :wincmd =

" Store swap files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" additional filetype detection
autocmd BufRead,BufNewFile *.axlsx set filetype=ruby

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

" FZF
nnoremap <c-f> :FZF<Enter>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

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
let g:togglecursor_force = 'xterm'
let g:togglecursor_default = 'blinking_block'

"youcompleteme
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:EclimCompletionMethod = 'omnifunc'

" easytags
" let g:easytags_cmd = 'exctags'
set tags=./tags;
let g:easytags_dynamic_files = 2
let g:easytags_async = 1

" vim-json
let g:vim_json_syntax_conceal = 0

" tagbar
nmap <C-t> :TagbarToggle<CR>

" emmet expansions
let g:user_emmet_leader_key = '<c-e>'

" gitgutter
set signcolumn=yes

" indentline
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 'black'
let g:indentLine_char = '│'
let g:indentLine_concealcursor=0

" airline
" let g:airline_theme='solarized'
" let g:airline_solarized_bg='dark'
call airline#parts#define_minwidth('ffenc', 50000)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#ale#error_symbol = '✘: '
let g:airline#extensions#ale#warning_symbol = '⚠ : '
let g:airline_powerline_fonts = 1

" ale
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermfg=160
highlight ALEWarningSign ctermfg=220
highlight ALEWarning ctermbg=236
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

" :hi CursorColumn cterm=NONE ctermbg=338
" :hi CursorLine cterm=NONE ctermbg=338

" a little suggestion...
:hi ColorColumn ctermbg=234
" let &colorcolumn=join(range(81,999),",")
:set colorcolumn=80

" set tmux window name automatically
augroup Tmux "{{{2
  au!
  " autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim-' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
  autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim"')
  autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END
