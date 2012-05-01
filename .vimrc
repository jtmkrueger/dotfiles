set encoding=utf-8
color solarized

" set clipboard=unnamed
"Map shift + enter to esc
inoremap jj <Esc>

" just hit semi instead
noremap ; :

set showtabline=2

au FocusLost * :silent! wall " Save on FocusLost
au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost 

" easier beginning & end of lines
noremap H ^
noremap L $

" make it easier to ack
noremap <C-l> :Ack! 

" I want my custom commands
imap <C-n> <%= %><Left><Left><Left>

" turn on wildmenu
set wildmenu

" search gems in guardfile with ctags
set tags+=gems.tags

" trailing white space and tabs
set listchars=tab:▸\ ,trail:⋅

highlight NonText ctermfg=Red
highlight SpecialKey ctermfg=Red

set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l

" up/down on wrapped lines
nnoremap j gj
nnoremap k gk

set cursorline
set cursorcolumn

" opening new tab with ctrlp
let g:ctrlp_arg_map = 1

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" mouse reporting for iterm2
set mouse=a

" clear search highlights with enter
nnoremap <CR> :nohlsearch<CR>/<BS>

" Open new splits to the right/bottom
set splitright splitbelow

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

let g:Powerline_symbols = 'fancy'
" let g:user_zen_expandabbr_key = '<c-e>'
