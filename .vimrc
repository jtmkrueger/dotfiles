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
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" " colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'jtmkrueger/grb256'

" " tools
Plug 'github/copilot.vim'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'jszakmeister/vim-togglecursor'
Plug 'Raimondi/delimitMate'
Plug 'elzr/vim-json'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'itchyny/vim-cursorword'
Plug 'Yggdroot/indentLine'

" all that tpope!
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'

" Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
call plug#end()
" END plug ------------------------

packadd! dracula_pro
filetype plugin on
syntax on

set guifont=mononoki-Regular\ Nerd\ Font\ Complete:h11
set guioptions-=e
set ttyfast
" set lazyredraw
" set shell=/bin/bash
set background=dark

let g:dracula_colorterm = 0
colorscheme dracula_pro

highlight Comment cterm=italic

" tab styles
set showtabline=2 " always show tabs

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
autocmd FileType go setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd FileType mod setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
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
" set laststatus=0 " no status line
" hi StatusLine   ctermfg=gray      ctermbg=16  gui=none  term=none      cterm=none
" hi StatusLineNC ctermfg=darkgray  ctermbg=16  gui=none  term=none      cterm=none

" set statusline=%f

" just save when I change tabs or leave the vim
" set autowriteall
" autocmd TextChanged,TextChangedI,FocusLost,InsertLeave *
"     \ if &buftype ==# '' || &buftype == 'acwrite' |
"     \     update |
"     \ endif

set scrolloff=5 " 5 line buffer below cursor when scrolling
set hlsearch " highlight search results
set cursorline " highlight line cursor is on
set cursorcolumn " highlight the cursors current col
set clipboard=unnamed " copy to system register
set mouse=a " turn on all mouse functionality
set timeoutlen=300 " Time to wait after ESC (default causes an annoying delay)
set list
set listchars=tab:⬝➜
set conceallevel=0
set completeopt=menu,menuone,noselect,noinsert
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

" HOLY SHIT the new engine just kills ruby files. This drastically improves performance!
set regexpengine=1

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

" " Resize splits when the window is resized
au VimResized * :wincmd =

" Store swap files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
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
autocmd BufRead,BufNewFile *.inky set filetype=slim

" map leader to space
let mapleader = "\<Space>"

" neovim needs to be like vim
nnoremap Y Y

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

" FZF
" nnoremap <c-f> :FZF<Enter>
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-s': 'split',
"   \ 'ctrl-v': 'vsplit' }

nnoremap <c-f> <cmd>Telescope find_files<cr>
nnoremap <c-a> <cmd>Telescope live_grep<cr>

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
let g:indentLine_concealcursor='nc'

" COC
" Use tab for trigger completion with characters ahead and navigate.
let g:coc_global_extensions = ['coc-solargraph']
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

" Use h to show documentation in preview window.
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>

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
let g:ale_completion_enabled = 0
highlight ALEErrorSign ctermfg=red
highlight ALEWarningSign ctermfg=red
" let g:ale_ruby_rubocop_executable = '/Users/jk/.gem/ruby/2.7.1/bin/rubocop'
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'scss': ['prettier'],
\   'ruby': ['rubocop', 'reek', 'rails_best_practices', 'brakeman', 'debride']
\}
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'ruby': ['rubocop']
\}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 1
nmap <C-g> :ALEGoToDefinitionInTab<CR>

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   ':%d ✘:%d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" set tmux window name automatically
augroup Tmux "{{{2
  au!
  " autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim-' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
  autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "nvim"')
  autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END

lua << END
  require('lualine').setup{
    options = { theme = 'dracula' },
    sections = {
      lualine_b = {
        {'filename', path = 1}
      },
      lualine_c = {},
      lualine_x = {'filetype'},
      lualine_y = {'LinterStatus'},
    },
    tabline = {
      lualine_a = {
        {'tabs', mode = 3}
      },
      lualine_x = {'nvim_treesitter#statusline'},
      lualine_z = {'diagnostics', 'diff', 'branch'},
    }
  }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
  }
END
