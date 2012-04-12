set encoding=utf-8
color solarized

" set clipboard=unnamed
"Map shift + enter to esc
inoremap jj <Esc>

" just hit semi instead
noremap ; :

set showtabline=2

" change splits from normal mode
nmap <Tab> <C-W>W

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

" set cursorline
" set cursorcolumn

" opening new tab with ctrlp
let g:ctrlp_arg_map = 1

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" change cursor shape in insert mode ONLY FOR ITERM2!
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" mouse reporting for iterm2
set mouse=a

" clear search highlights with enter
nnoremap <CR> :nohlsearch<CR>/<BS>


:noremap <left> :tabprevious<CR>
:noremap <right> :tabnext<CR>

" Open new splits to the right/bottom
set splitright splitbelow
