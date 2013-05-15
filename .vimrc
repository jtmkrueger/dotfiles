syntax on
" set background=dark
"filetype plugin indent on
set encoding=utf-8
set t_Co=256
set laststatus=2
set nocompatible
set tabstop=2 softtabstop=2 shiftwidth=2
set wildmenu " turn on wildmenu
set listchars=tab:▸\ ,trail:⋅ " trailing white space and tabs
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l
set number
set directory=~/tmp
" Open new splits to the right/bottom
set splitright splitbelow
set clipboard=unnamed

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
