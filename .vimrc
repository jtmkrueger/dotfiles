syntax on
set background=light
set encoding=utf-8
set t_Co=256
set laststatus=2
" change status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=5 guibg=DarkYellow
  au InsertLeave * hi StatusLine ctermfg=2 guibg=#255150
endif
set cursorline
set nocompatible
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
set backspace=start,eol,indent
set wildmenu " turn on wildmenu
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

" set directory=~/vimtmp//
set nobackup
set nowritebackup

" Open new splits to the right/bottom
set splitright splitbelow
set clipboard=unnamed
set mouse=a

highlight NonText ctermfg=Red
highlight SpecialKey ctermfg=Red

" I want my custom commands
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

" smart kid splits
noremap <left> <C-w>>
noremap <right> <C-w><
noremap <up> <C-w>-
noremap <down> <C-w>+
