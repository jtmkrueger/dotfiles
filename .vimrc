syntax on
filetype plugin indent on
set encoding=utf-8
set t_Co=256
set laststatus=2
set nocompatible
set tabstop=2 softtabstop=2 shiftwidth=2
set showtabline=2
set wildmenu " turn on wildmenu
set tags+=gems.tags " search gems in guardfile with ctags
set listchars=tab:▸\ ,trail:⋅ " trailing white space and tabs
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l
" Open new splits to the right/bottom
set splitright splitbelow
set clipboard=unnamed

highlight NonText ctermfg=Red
highlight SpecialKey ctermfg=Red

call pathogen#infect()

inoremap jj <Esc>
" make it easier to ack
noremap <C-l> :Ag! 
noremap <C-c> :! 
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

" Bubble single lines of text
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines of text
vmap <C-k> [egv
vmap <C-j> ]egv

" smart kid splits
noremap <left> <C-w>>
noremap <right> <C-w><
noremap <up> <C-w>-
noremap <down> <C-w>+

" smart kid window movement
nnoremap <Tab>h <C-w>h
nnoremap <Tab>j <C-w>j
nnoremap <Tab>k <C-w>k
nnoremap <Tab>l <C-w>l

" additional syntaxes
au BufNewFile,BufRead *.csvbuilder set filetype=ruby
