" START plug ----------------------------
call plug#begin('~/.vim/plugged')

" " syntaxes
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
Plug 'slim-template/vim-slim'

" " colorschemes
Plug 'w0ng/vim-hybrid'

" " tools
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'jszakmeister/vim-togglecursor'
Plug 'Raimondi/delimitMate'
Plug 'elzr/vim-json'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'itchyny/vim-cursorword'
Plug 'Yggdroot/indentLine'

" all that tpope!
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'

Plug 'ryanoasis/vim-devicons'
call plug#end()
" END plug ------------------------

filetype plugin on
syntax on

" packadd! dracula_pro

set guifont=mononoki-Regular\ Nerd\ Font\ Complete:h11
set guioptions-=e
set ttyfast
" set lazyredraw
set shell=/bin/bash
set background=dark
" set termguicolors
"
" Dracula theme
" let g:dracula_italic = 1

let g:hybrid_custom_term_colors = 1
colorscheme hybrid
highlight Comment cterm=italic
set t_ZH=[3m
set t_ZR=[23m
set encoding=UTF-8
set fileencoding=utf-8
" set t_Co=256
set magic "for regular epressions turn magic on

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
set number " line numbers

" this is all for the tabline
set showtabline=2 " always show tabs

set scrolloff=5 " 5 line buffer below cursor when scrolling
set hlsearch " highlight search results
set cursorline " highlight line cursor is on
" set cursorcolumn " highlight the cursors current col
set clipboard=unnamed " copy to system register
set mouse=a " turn on all mouse functionality
set timeoutlen=300 " Time to wait after ESC (default causes an annoying delay)
set list
set listchars=tab:⬝➜
set conceallevel=0
set completeopt=menu,menuone,noselect,noinsert

" HOLY SHIT the new engine just kills ruby files. This drastically improves performance!
set regexpengine=1

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

" " Resize splits when the window is resized
au VimResized * :wincmd =

" Store swap files in a central spot
" set backup
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup
set nowritebackup
set shortmess+=c

" you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

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

" easy search with the silver searcher
let g:ackprg = 'ag --nogroup --column'
nnoremap <c-a> :Ack!<Space>

" FZF
nnoremap <c-f> :FZF<Enter>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" togglecursor
let g:togglecursor_force = 'xterm'
let g:togglecursor_default = 'blinking_block'

" vim-json
let g:vim_json_syntax_conceal = 0

" emmet expansions
let g:user_emmet_leader_key = '<c-e>'

" gitgutter
set signcolumn=yes

" indentline
let g:indentLine_setColors=1
let g:indentLine_char = '│'
let g:indentLine_concealcursor=0

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#ale#error_symbol = '✘: '
let g:airline#extensions#ale#warning_symbol = ' : '
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%l/%L:%c'
let g:airline_left_sep=''
let g:airline_right_sep=''


" COC
" Use tab for trigger completion with characters ahead and navigate.
" :CocInstall coc-solargraph ***to get ruby going
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ale
" Available language servers: 
"   ruby (solargraph)
let g:ale_sign_error = '✘'
let g:ale_sign_warning = ''
" let g:ale_completion_enabled = 1
highlight ALEErrorSign ctermfg=red
highlight ALEWarningSign ctermfg=red
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop', 'reek']
\}
let g:ale_lint_on_text_changed = 0
nmap <C-g> :ALEGoToDefinitionInTab<CR>

" set tmux window name automatically
augroup Tmux "{{{2
  au!
  " autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim-' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
  autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim"')
  autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END
